extends Node

export(Array, Material) var materials


func _ready() -> void:
	# Load these materials
	for m in materials:
		if m is SpatialMaterial:
			load_spatial(m)
			pass
		elif m is ParticlesMaterial || m is ShaderMaterial:
			load_particles(m)
	
	yield(get_tree(),"idle_frame")
	#yield(get_tree().create_timer(3), "timeout")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	#yield(get_tree(),"idle_frame")
	
	# Remove all children
	for c in get_children():
		remove_child(c)


func load_spatial(m):
	# Create new spatial object
	var spatial_object = MeshInstance.new()
	spatial_object.set_mesh(CubeMesh.new())
	add_child(spatial_object)
	spatial_object.owner = self
	
	# Apply Material
	spatial_object.material_override = m


func load_particles(m):
	# Create new particle system
	var particles:Particles = Particles.new()
	add_child(particles)
	particles.owner = self
	
	# Apply Material
	particles.process_material = m
	particles.draw_pass_1 = QuadMesh.new()
	particles.translation = Vector3(0,2.0,0.0)
	particles.rotation = Vector3(-90,0,0)
	particles.emitting = true

	

