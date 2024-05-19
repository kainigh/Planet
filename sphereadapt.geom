#version 400 compatibility
#extension GL_EXT_gpu_shader4: enable
#extension GL_EXT_geometry_shader4: enable

#define uProjectionMatrix gl_ProjectionMatrix

layout( triangles )  in;
layout( triangle_strip, max_vertices=200 )  out;

uniform float uShrink;
uniform int uLOD = 1;
uniform float uStep = 0.1f;
uniform float uDroop = 0.3f;

in vec3 teNormal[3];

flat out vec3 gNormalF;
     out vec3 gNormalS;
     out vec3 gPosition;

vec3 V[3];
vec3 CG;

vec3 Norm[3];
vec3 N0, N01, N02;
vec4 V0, V01, V02;

void
ProduceVertex( int v )
{

	gNormalF = gNormalS = teNormal[v];
	gPosition = V[v];
	gl_Position = uProjectionMatrix * vec4( CG + uShrink * ( V[v] - CG ), 1. );
	EmitVertex( );
}

/*
void
ProduceVertices( float s, float t )
{
	vec4 v = V0 + s*V01 + t*V02;
	vec3 n = normalize( N0 + s*N01 + t*N02 );

	for( int i = 0; i <= 1; i++ )
	{
		gl_Position = gl_ProjectionMatrix * v;
		//gColor = vColor[0];
		EmitVertex( );
		v.xyz += uStep * n;
		//v.y -= uDroop * float(i*i);
	}
	EndPrimitive();
}

void
main()
{
	V0  =   gl_PositionIn[0];
	V01 = ( gl_PositionIn[1] - gl_PositionIn[0] );
	V02 = ( gl_PositionIn[2] - gl_PositionIn[0] );

	Norm[0] = teNormal[0];
	Norm[1] = teNormal[1];
	Norm[2] = teNormal[2];

	if( dot( Norm[0], Norm[1] ) < 0. )
		Norm[1] = -Norm[1];

	if( dot( Norm[0], Norm[2] ) < 0. )
		Norm[2] = -Norm[2];

	N0  = normalize( Norm[0] );
	N01 = normalize( Norm[1] - Norm[0] );
	N02 = normalize( Norm[2] - Norm[0] );

	int numLayers = 1 << uLOD;

	float dt = 1. / float( numLayers );
	float t = 1.;

	for( int it = 0; it <= numLayers; it++ )
	{
		float smax = 1. - t;

		int nums = it + 1;
		float ds = smax / float( nums - 1 );

		float s = 0.;
		for( int is = 0; is < nums; is++ )
		{
			ProduceVertices( s, t );
			s += ds;
		}

		t -= dt;
	}

	ProduceVertex( 0 );
	ProduceVertex( 1 );
	ProduceVertex( 2 );
}
*/




void
main( )
{
	
	V[0]  =   gl_PositionIn[0].xyz;
	V[1]  =   gl_PositionIn[1].xyz;
	V[2]  =   gl_PositionIn[2].xyz;

	CG = ( V[0] + V[1] + V[2] ) / 3.;

	ProduceVertex( 0 );
	ProduceVertex( 1 );
	ProduceVertex( 2 );
}

