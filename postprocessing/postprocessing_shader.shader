shader_type spatial;
render_mode unshaded, cull_back, shadows_disabled, depth_test_disable;

uniform vec4 color : hint_color;
uniform vec4 background : hint_color;
uniform float color_sens;
uniform float depth_sens;

uniform float lower_threshold = 0.05;
uniform float upper_threshold = 0.5;
uniform float dist_falloff = 40.0;
uniform float pixel_scale = 0.5;

//uniform float inverse_fall_off;
//uniform float inverse_range;

uniform float threshold;



float Linear01Depth(float z, vec2 screen_uv, mat4 inv_proj_mat) {
	vec3 ndc = vec3(screen_uv, z) * 2.0 - 1.0;
	vec4 view = inv_proj_mat * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z / dist_falloff;
	return linear_depth;
}

float LinearEyeDepth(float z,  vec2 screen_uv, mat4 inv_proj_mat) {
	/// PERSP
	return Linear01Depth(z, screen_uv, inv_proj_mat) * dist_falloff;
	/// ORTHO
	//return z;
	//return z * dist_falloff* dist_falloff;
}

void vertex() {
	POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	
	float inverse_fall_off = 1.0 / dist_falloff;
	
	vec4 c0 = texture(SCREEN_TEXTURE, SCREEN_UV).rgba;
	ivec2 tex_size = textureSize(SCREEN_TEXTURE, 0);
	vec2 texel_size = vec2(pixel_scale / float(tex_size.x), pixel_scale / float(tex_size.y));
	// Four sample points of the roberts cross operator
	vec2 uv0 = SCREEN_UV;                            // TL
	vec2 uv1 = SCREEN_UV + texel_size.xy;           // BR
	vec2 uv2 = SCREEN_UV + vec2(texel_size.x, 0);  // TR
	vec2 uv3 = SCREEN_UV + vec2(0, texel_size.y); // BL
	
	float edge = 0.0;
	
	// Color samples
	vec3 c1 = texture(SCREEN_TEXTURE, uv1).rgb;
	vec3 c2 = texture(SCREEN_TEXTURE, uv2).rgb;
	vec3 c3 = texture(SCREEN_TEXTURE, uv3).rgb;
	
	// Roberts cross operator
	vec3 cg1 = c1 - c0.rgb;
	vec3 cg2 = c3 - c2;
	float cg = sqrt(dot(cg1, cg1) + dot(cg2, cg2));
	
	edge = cg * color_sens;
	// End Color
	
	// Depth samples
    float zs0 = texture(DEPTH_TEXTURE, uv0).r;
    float zs1 = texture(DEPTH_TEXTURE, uv1).r;
    float zs2 = texture(DEPTH_TEXTURE, uv2).r;
    float zs3 = texture(DEPTH_TEXTURE, uv3).r;
	
	
    // Calculate fall-off parameter from the depth of the nearest point
    float zm = min(min(min(zs0, zs1), zs2), zs3);
    float falloff = 1.0 - clamp((LinearEyeDepth(zm, SCREEN_UV, INV_PROJECTION_MATRIX) * inverse_fall_off), 0.0, 1.0);

    // Convert to linear depth values.
    float z0 = Linear01Depth(zs0, SCREEN_UV, INV_PROJECTION_MATRIX);
    float z1 = Linear01Depth(zs1, SCREEN_UV, INV_PROJECTION_MATRIX);
    float z2 = Linear01Depth(zs2, SCREEN_UV, INV_PROJECTION_MATRIX);
    float z3 = Linear01Depth(zs3, SCREEN_UV, INV_PROJECTION_MATRIX);

    // Roberts cross operator
    float zg1 = z1 - z0;
    float zg2 = z3 - z2;
    float zg = sqrt(zg1 * zg1 + zg2 * zg2);

    edge = max(edge, zg * falloff * depth_sens / Linear01Depth(zm, SCREEN_UV, INV_PROJECTION_MATRIX));
	// End Depth
	
	// Thresholding
	float inverse_range = 1.0 / (upper_threshold - lower_threshold);
	
	edge = clamp((edge - threshold) * inverse_range, 0.0, 1.0);
	
	vec3 cb = mix(c0.rgb, background.rgb, background.a);
	vec3 co = mix(cb, color.rgb, edge * color.a);
	

	ALBEDO = co;
	
	//ALBEDO = mix(c0.rgb, vec3(z0,z0,z0), 0.9);
}

