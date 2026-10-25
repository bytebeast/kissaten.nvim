# Photoreal kissaten still life for the social preview, rendered with Cycles:
# a glass coffee siphon over a candle, a ceramic cup of coffee on a saucer,
# a walnut counter, and warm café lights far behind (blurred by depth of field).
# Everything is made up.
#
# Run with Blender's Python module (pip install bpy, Python 3.11):
#   python scripts/social_scene.py render.png 1280 128
# then add a light bloom and a 2.5px Gaussian blur and save the result as
# assets/src/social-background.jpg; scripts/make_assets.py draws the text on top.
import math
import sys

import bpy  # noqa: I001 (bmesh needs bpy loaded first)
import bmesh
from mathutils import Vector

out = sys.argv[1] if len(sys.argv) > 1 else "render.png"
width = int(sys.argv[2]) if len(sys.argv) > 2 else 640
samples = int(sys.argv[3]) if len(sys.argv) > 3 else 32

bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene

# ── helpers ─────────────────────────────────────────────────────────────
def mat(name, color=(0.8, 0.8, 0.8), rough=0.4, metal=0.0, transmission=0.0, ior=1.45, coat=0.0,
        sss=0.0, sss_radius=(1, 0.5, 0.25), emission=None, strength=0.0, alpha=1.0):
    m = bpy.data.materials.new(name)
    m.use_nodes = True
    b = m.node_tree.nodes["Principled BSDF"]
    b.inputs["Base Color"].default_value = (*color, 1)
    b.inputs["Roughness"].default_value = rough
    b.inputs["Metallic"].default_value = metal
    b.inputs["Transmission Weight"].default_value = transmission
    b.inputs["IOR"].default_value = ior
    b.inputs["Coat Weight"].default_value = coat
    b.inputs["Subsurface Weight"].default_value = sss
    b.inputs["Subsurface Radius"].default_value = sss_radius
    if emission:
        b.inputs["Emission Color"].default_value = (*emission, 1)
        b.inputs["Emission Strength"].default_value = strength
    return m


def link(obj, m):
    obj.data.materials.clear()
    obj.data.materials.append(m)
    return obj


def smooth(obj, subdiv=0):
    for p in obj.data.polygons:
        p.use_smooth = True
    if subdiv:
        mod = obj.modifiers.new("sub", "SUBSURF")
        mod.levels = mod.render_levels = subdiv
    return obj


def lathe(name, profile, steps=96, thickness=0.0, close_bottom=False, flip=False):
    """Revolve a list of (radius, z) points around Z."""
    me = bpy.data.meshes.new(name)
    bm = bmesh.new()
    verts = [bm.verts.new((r, 0, z)) for r, z in profile]
    for a, b in zip(verts, verts[1:]):
        bm.edges.new((a, b))
    bm.to_mesh(me)
    bm.free()
    obj = bpy.data.objects.new(name, me)
    scene.collection.objects.link(obj)
    scr = obj.modifiers.new("lathe", "SCREW")
    scr.steps = scr.render_steps = steps
    scr.use_merge_vertices = True
    scr.use_smooth_shade = True
    scr.use_normal_flip = flip
    if thickness:
        sol = obj.modifiers.new("shell", "SOLIDIFY")
        sol.thickness = thickness
        sol.offset = -1
    return obj


def cyl(name, r, h, loc, verts=64):
    bpy.ops.mesh.primitive_cylinder_add(radius=r, depth=h, location=loc, vertices=verts)
    o = bpy.context.object
    o.name = name
    return smooth(o)


def sphere(name, r, loc, seg=96, rings=48):
    bpy.ops.mesh.primitive_uv_sphere_add(radius=r, location=loc, segments=seg, ring_count=rings)
    o = bpy.context.object
    o.name = name
    return smooth(o)


def cut_below(obj, z_world, fill=True):
    """Keep only the part of a mesh below z (a liquid level), capping the top."""
    me = obj.data
    bm = bmesh.new()
    bm.from_mesh(me)
    local_z = z_world - obj.location.z
    geom = bm.verts[:] + bm.edges[:] + bm.faces[:]
    res = bmesh.ops.bisect_plane(bm, geom=geom, plane_co=(0, 0, local_z), plane_no=(0, 0, 1), clear_outer=True)
    if fill:
        edges = [e for e in res["geom_cut"] if isinstance(e, bmesh.types.BMEdge)]
        bmesh.ops.holes_fill(bm, edges=edges)
    bm.to_mesh(me)
    bm.free()
    return obj


# ── materials ───────────────────────────────────────────────────────────
glass = mat("glass", (1, 1, 1), rough=0.0, transmission=1.0, ior=1.47)
coffee = mat("coffee", (1, 1, 1), rough=0.02, transmission=1.0, ior=1.34)
_cn = coffee.node_tree
_abs = _cn.nodes.new("ShaderNodeVolumeAbsorption")
_abs.inputs["Color"].default_value = (0.62, 0.30, 0.10, 1)
_abs.inputs["Density"].default_value = 70
_cn.links.new(_abs.outputs["Volume"], _cn.nodes["Material Output"].inputs["Volume"])
crema = mat("crema", (0.32, 0.17, 0.08), rough=0.35)
metal = mat("metal", (0.10, 0.10, 0.11), rough=0.28, metal=1.0)
brass = mat("brass", (0.55, 0.42, 0.22), rough=0.3, metal=1.0)
ceramic = mat("ceramic", (0.86, 0.83, 0.78), rough=0.12, coat=0.6)
wax = mat("wax", (0.95, 0.84, 0.66), rough=0.35, sss=1.0, sss_radius=(0.012, 0.006, 0.003))
_wn = wax.node_tree
_wb = _wn.nodes["Principled BSDF"]
_wtc = _wn.nodes.new("ShaderNodeTexCoord")
_wsep = _wn.nodes.new("ShaderNodeSeparateXYZ")
_wr = _wn.nodes.new("ShaderNodeValToRGB")
_wr.color_ramp.elements[0].position, _wr.color_ramp.elements[0].color = 0.0, (0.10, 0.04, 0.012, 1)
_wr.color_ramp.elements[1].position, _wr.color_ramp.elements[1].color = 1.0, (1.0, 0.45, 0.12, 1)
_wn.links.new(_wtc.outputs["Generated"], _wsep.inputs["Vector"])
_wn.links.new(_wsep.outputs["Z"], _wr.inputs["Fac"])
_wn.links.new(_wr.outputs["Color"], _wb.inputs["Emission Color"])
_wb.inputs["Emission Strength"].default_value = 1.2
wick = mat("wick", (0.012, 0.009, 0.007), rough=0.9)

# wood: dark walnut grain from a stretched wave texture
wood = bpy.data.materials.new("wood")
wood.use_nodes = True
nt = wood.node_tree
bsdf = nt.nodes["Principled BSDF"]
wave = nt.nodes.new("ShaderNodeTexWave")
wave.wave_type = "BANDS"
wave.inputs["Scale"].default_value = 6
wave.inputs["Distortion"].default_value = 8
wave.inputs["Detail"].default_value = 6
mapn = nt.nodes.new("ShaderNodeMapping")
mapn.inputs["Scale"].default_value = (1, 12, 1)
coord = nt.nodes.new("ShaderNodeTexCoord")
nt.links.new(coord.outputs["Object"], mapn.inputs["Vector"])
nt.links.new(mapn.outputs["Vector"], wave.inputs["Vector"])
ramp = nt.nodes.new("ShaderNodeValToRGB")
ramp.color_ramp.elements[0].color = (0.035, 0.018, 0.010, 1)
ramp.color_ramp.elements[1].color = (0.11, 0.055, 0.03, 1)
nt.links.new(wave.outputs["Fac"], ramp.inputs["Fac"])
nt.links.new(ramp.outputs["Color"], bsdf.inputs["Base Color"])
bsdf.inputs["Roughness"].default_value = 0.32
bsdf.inputs["Coat Weight"].default_value = 0.35

# flame: emission graded from blue at the base to white-yellow to orange tip
flame = bpy.data.materials.new("flame")
flame.use_nodes = True
fn = flame.node_tree
fn.nodes.clear()
fo = fn.nodes.new("ShaderNodeOutputMaterial")
em = fn.nodes.new("ShaderNodeEmission")
tr = fn.nodes.new("ShaderNodeBsdfTransparent")
mix = fn.nodes.new("ShaderNodeMixShader")
tc = fn.nodes.new("ShaderNodeTexCoord")
sep = fn.nodes.new("ShaderNodeSeparateXYZ")
fr = fn.nodes.new("ShaderNodeValToRGB")
fn.links.new(tc.outputs["Generated"], sep.inputs["Vector"])
fn.links.new(sep.outputs["Z"], fr.inputs["Fac"])
els = fr.color_ramp.elements
els[0].position, els[0].color = 0.0, (0.05, 0.12, 0.8, 1)
els[1].position, els[1].color = 1.0, (0.9, 0.12, 0.01, 1)
for pos, col in [(0.07, (1.0, 0.85, 0.5, 1)), (0.22, (1.0, 0.62, 0.15, 1)), (0.5, (1.0, 0.38, 0.04, 1))]:
    e = els.new(pos)
    e.color = col
fn.links.new(fr.outputs["Color"], em.inputs["Color"])
em.inputs["Strength"].default_value = 2.2
# soft edges: facing ratio fades the rim to transparent
lw = fn.nodes.new("ShaderNodeLayerWeight")
lw.inputs["Blend"].default_value = 0.35
fn.links.new(lw.outputs["Facing"], mix.inputs["Fac"])
fn.links.new(em.outputs["Emission"], mix.inputs[1])
fn.links.new(tr.outputs["BSDF"], mix.inputs[2])
fn.links.new(mix.outputs["Shader"], fo.inputs["Surface"])

# ── counter and wall ────────────────────────────────────────────────────
bpy.ops.mesh.primitive_plane_add(size=1, location=(0, 0.5, 0))
counter = bpy.context.object
counter.scale = (4, 2.2, 1)
link(counter, wood)

wallm = mat("wall", (0.03, 0.032, 0.06), rough=0.9)
bpy.ops.mesh.primitive_plane_add(size=1, location=(0, 3.2, 1.0), rotation=(math.radians(90), 0, 0))
wall = bpy.context.object
wall.scale = (8, 4, 1)
link(wall, wallm)

# ── siphon ──────────────────────────────────────────────────────────────
SX, SY = 0.05, 0.0  # siphon axis on the counter
# stand: base plate, rod, arm with a clamp ring
link(cyl("base", 0.075, 0.012, (SX, SY, 0.006)), metal)
link(cyl("rod", 0.006, 0.33, (SX + 0.085, SY + 0.01, 0.17)), metal)
link(cyl("arm", 0.005, 0.085, (SX + 0.043, SY + 0.01, 0.245)), metal).rotation_euler = (0, math.radians(90), 0)
bpy.ops.mesh.primitive_torus_add(major_radius=0.02, minor_radius=0.003, location=(SX, SY, 0.245))
link(smooth(bpy.context.object), metal)

# candle (heat source) under the flask
candle = lathe("candle", [(0.0, 0.012), (0.026, 0.012), (0.026, 0.044), (0.024, 0.0465), (0.016, 0.045),
                          (0.004, 0.0425), (0.0, 0.0425)])
candle.location = (SX, SY, 0)
link(candle, wax)
wk = cyl("wick", 0.0011, 0.011, (SX, SY, 0.047), verts=12)
wk.rotation_euler = (0, math.radians(6), 0)
link(wk, wick)
# teardrop flame: a revolved profile, round at the base and pointed at the tip
bpy.ops.mesh.primitive_uv_sphere_add(radius=0.0052, location=(SX + 0.0006, SY, 0.0565), segments=48, ring_count=32)
fl = smooth(bpy.context.object)
fl.name = "flame"
for v in fl.data.vertices:
    t = v.co.z / 0.0052  # -1 (bottom) .. 1 (top)
    if t > 0:
        # stretch the upper half and narrow it to a point
        v.co.x *= 1 - 0.85 * t ** 1.4
        v.co.y *= 1 - 0.85 * t ** 1.4
        v.co.z *= 3.2
link(fl, flame)
bpy.ops.object.light_add(type="POINT", location=(SX, SY, 0.062))
candle_light = bpy.context.object
candle_light.data.energy = 9
candle_light.data.color = (1.0, 0.5, 0.18)
candle_light.data.shadow_soft_size = 0.006

# lower flask: glass sphere with neck, coffee inside
FZ = 0.152
link(sphere("flask", 0.062, (SX, SY, FZ)), glass).modifiers.new("shell", "SOLIDIFY").thickness = 0.0025
link(cyl("neck", 0.017, 0.045, (SX, SY, FZ + 0.075)), glass).modifiers.new("shell", "SOLIDIFY").thickness = 0.002
liq = cut_below(sphere("coffee_low", 0.0585, (SX, SY, FZ)), FZ + 0.005)
link(liq, coffee)

# upper bowl: revolved profile with a tube down into the flask
bowl = lathe(
    "bowl",
    [(0.006, FZ - 0.03), (0.007, FZ + 0.09), (0.012, FZ + 0.105), (0.03, FZ + 0.125), (0.047, FZ + 0.165),
     (0.054, FZ + 0.215), (0.055, FZ + 0.245), (0.058, FZ + 0.25)],
    thickness=0.002,
)
bowl.location = (SX, SY, 0)
link(bowl, glass)
up = lathe("coffee_up", [(0.0, FZ + 0.106), (0.011, FZ + 0.107), (0.029, FZ + 0.127), (0.046, FZ + 0.167),
                         (0.0505, FZ + 0.19), (0.0, FZ + 0.19)])
up.location = (SX, SY, 0)
link(up, coffee)
foam = cyl("foam", 0.0505, 0.004, (SX, SY, FZ + 0.191))
link(foam, crema)

# ── cup on a saucer ─────────────────────────────────────────────────────
CX, CY = -0.13, -0.05
saucer = lathe("saucer", [(0.0, 0.002), (0.045, 0.002), (0.062, 0.006), (0.078, 0.014), (0.08, 0.016)], thickness=0.004)
saucer.location = (CX, CY, 0)
link(saucer, ceramic)
cup = lathe("cup", [(0.0, 0.012), (0.028, 0.012), (0.034, 0.016), (0.042, 0.04), (0.046, 0.065), (0.047, 0.072)],
            thickness=0.004)
cup.location = (CX, CY, 0)
link(cup, ceramic)
surface = cyl("coffee_cup", 0.0425, 0.003, (CX, CY, 0.064))
link(surface, crema)
bpy.ops.mesh.primitive_torus_add(major_radius=0.017, minor_radius=0.0045, location=(CX + 0.058, CY, 0.044),
                                 rotation=(math.radians(90), 0, 0), major_segments=64, minor_segments=24)
link(smooth(bpy.context.object), ceramic)

# ── background: café lights, far enough to melt into bokeh ──────────────
import random

rnd = random.Random(5)
palette = [(1.0, 0.55, 0.22), (1.0, 0.68, 0.32), (1.0, 0.48, 0.25), (0.95, 0.60, 0.40), (0.62, 0.58, 1.0), (1.0, 0.75, 0.45)]
for i in range(30):
    x = rnd.uniform(-1.9, 1.9)
    y = rnd.uniform(2.2, 3.0)
    z = rnd.uniform(0.3, 1.25)
    bpy.ops.mesh.primitive_uv_sphere_add(radius=rnd.uniform(0.01, 0.022), location=(x, y, z), segments=16, ring_count=8)
    b = bpy.context.object
    c = rnd.choice(palette)
    # dimmer on the left, where the title sits
    k = 0.45 if x < -0.6 else 1.0
    link(b, mat(f"bulb{i}", c, emission=c, strength=rnd.uniform(5, 14) * k))
# a warm pendant glow above, out of frame, and a soft window light from the left
bpy.ops.object.light_add(type="AREA", location=(-0.7, -0.3, 0.6))
key = bpy.context.object
key.data.energy = 6
key.data.size = 0.6
key.data.color = (1.0, 0.78, 0.55)
key.rotation_euler = (math.radians(70), 0, math.radians(-60))
bpy.ops.object.light_add(type="AREA", location=(0.8, 0.6, 0.5))
rim = bpy.context.object
rim.data.energy = 4
rim.data.size = 0.3
rim.data.color = (0.75, 0.78, 1.0)
rim.rotation_euler = (math.radians(70), 0, math.radians(125))

def softbox(name, loc, rot, size, color, strength):
    bpy.ops.mesh.primitive_plane_add(size=1, location=loc, rotation=rot)
    o = bpy.context.object
    o.name = name
    o.scale = size
    link(o, mat(name, color, emission=color, strength=strength))
    o.visible_camera = False  # only reflections and light, never seen directly
    return o


softbox("box_left", (-0.45, -0.1, 0.42), (0, math.radians(90), math.radians(-30)), (0.4, 0.06, 1), (1.0, 0.82, 0.62), 6)
softbox("box_right", (0.45, 0.35, 0.45), (0, math.radians(90), math.radians(35)), (0.4, 0.05, 1), (0.75, 0.8, 1.0), 5)
softbox("box_top", (0.05, 0.1, 0.75), (0, 0, 0), (0.25, 0.25, 1), (1.0, 0.85, 0.7), 1.5)

world = bpy.data.worlds.new("w")
world.use_nodes = True
world.node_tree.nodes["Background"].inputs["Color"].default_value = (0.008, 0.009, 0.02, 1)
scene.world = world

# ── camera: 50 mm, eye level with the counter, shallow focus on the siphon ─
bpy.ops.object.camera_add(location=(0, -1.5, 0.19), rotation=(math.radians(90), 0, 0))
cam = bpy.context.object
cam.data.lens = 50
cam.data.shift_x = 0.035
cam.data.dof.use_dof = True
cam.data.dof.focus_distance = 1.5
cam.data.dof.aperture_fstop = 1.4
scene.camera = cam

# ── render ──────────────────────────────────────────────────────────────
scene.render.engine = "CYCLES"
scene.cycles.device = "CPU"
scene.cycles.samples = samples
scene.cycles.use_denoising = True
scene.cycles.max_bounces = 12
scene.cycles.transmission_bounces = 12
scene.cycles.transparent_max_bounces = 12
scene.cycles.caustics_reflective = False
scene.cycles.caustics_refractive = False
scene.cycles.blur_glossy = 1.0
scene.render.resolution_x = width
scene.render.resolution_y = width // 2
scene.render.resolution_percentage = 100
scene.view_settings.view_transform = "AgX"
scene.view_settings.look = "AgX - Medium High Contrast"
scene.view_settings.exposure = 0.0
import os
if os.environ.get("BORDER"):
    x0, x1, y0, y1 = map(float, os.environ["BORDER"].split(","))
    scene.render.use_border = True
    scene.render.use_crop_to_border = True
    scene.render.border_min_x, scene.render.border_max_x = x0, x1
    scene.render.border_min_y, scene.render.border_max_y = y0, y1
scene.render.filepath = out
bpy.ops.render.render(write_still=True)
print("wrote", out)
