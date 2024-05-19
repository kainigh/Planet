#version 330 compatibility

#define aTexCoord0 gl_MultiTexCoord0
#define uNormalMatrix gl_NormalMatrix
#define uModelViewMatrix gl_ModelViewMatrix
#define aNormal gl_Normal
#define aVertex gl_Vertex
#define uModelViewProjectionMatrix gl_ModelViewProjectionMatrix

uniform float uHeightScale = 1.25f;
uniform float uSeaLevel = 1.25f;
//uniform sampler2D uDispUnit;
uniform sampler3D Noise3;
uniform bool uDoElevations = true;

out vec3  vMCposition;
out float vLightIntensity; 
out float vZ;
out vec2  vST;

vec3 LIGHTPOS   = vec3( -2., 0., 10. );

void
main( )
{
	vST = aTexCoord0.st;

	vec3 tnorm      = normalize( vec3( uNormalMatrix * aNormal ) );
	vec3 ECposition = vec3( uModelViewMatrix * aVertex );
	vZ = ECposition.z;
	vLightIntensity  = abs( dot( normalize(LIGHTPOS - ECposition), tnorm ) );

	vMCposition  = aVertex.xyz;

	gl_Position = uModelViewProjectionMatrix * aVertex;
}
