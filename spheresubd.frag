#version 330 compatibility

uniform vec3 uColor;
in float gLightIntensity;

void main()
{
	gl_FragColor = vec4(gLightIntensity * uColor.rgb, 1.);

}
