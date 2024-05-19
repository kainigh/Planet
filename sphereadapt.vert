#version 400 compatibility

#define aVertex gl_Vertex


// vertex position
layout (location = 0) in vec4 aPos;
layout (location = 3) in vec2 aTex;

out vec2 TexCoord;

layout (location = 1) in vec2 TexCoord_VS_in;
layout (location = 2) in vec3 Normal_VS_in;

out vec2 TexCoord_CS_in;
out vec3 Normal_CS_in;

out vec3  vCenter;
out float vRadius;
out vec4 vColor;
out vec3 vTnorm;


void main( )
{

	TexCoord_CS_in = TexCoord_VS_in;
	//Normal_CS_in = gl_Vertex.xyz;
    //Normal_CS_in = (gl_ModelViewProjectionMatrix * vec4(Normal_VS_in, 0.0)).xyz;

	Normal_CS_in = gl_NormalMatrix * gl_Normal;
	
	vCenter = aPos.xyz;
	vRadius = aPos.w;

	TexCoord = aTex;

	gl_Position = vec4( 0., 0., 0., 1. );

}