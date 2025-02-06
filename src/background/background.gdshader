shader_type canvas_item;

uniform sampler2D noiseStars;
uniform sampler2D noiseClouds;
uniform float time;

void vertex() {
	// Vertex shader remains unchanged
}

void fragment() {
	vec4 stars = texture(noiseStars, UV);
	vec4 clouds = texture(noiseClouds, UV);

	// Create a twinkling effect for stars
	float twinkle = sin(time * 10.0 + UV.x * 20.0 + UV.y * 15.0) * 0.5 + 0.5;

	// Convert white pixels in stars to a cooler, dimmer color palette
	vec3 starColor1 = vec3(0.0, 212.0, 89.0) / 255.0; // #00d459
	vec3 starColor2 = vec3(102.0, 243.0, 144.0) / 255.0; // #66f390
	vec3 starColor = mix(starColor1, starColor2, sin(time + UV.x * 10.0) * 0.5 + 0.5);
	starColor *= stars.r * twinkle;

	// Add a subtle color variation to clouds, but darker
	vec3 cloudcolor1 = vec3(0.0, 88.0, 88.0)/255.0;
	vec3 cloudcolor2 = vec3(21.0, 189.0, 94.0)/255.0;
	vec3 cloudColor = mix(cloudcolor1, cloudcolor2, 1.0);
	vec3 coloredClouds = mix(cloudColor, clouds.rgb * 0.5, 0.7); // Darken clouds

	// Combine stars and clouds with a soft glow effect
	float cloudMask = smoothstep(0.4, 0.6, clouds.a);
	vec3 finalColor = starColor + coloredClouds;

	// Add a dark blue tint to the entire sky
	vec3 darkSkyTint = vec3(0.03, 0.05, 0.1);
	finalColor = mix(darkSkyTint, finalColor, 0.6);

	COLOR = vec4(finalColor, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
