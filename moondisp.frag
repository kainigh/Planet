#version 330 compatibility

uniform bool uDoLighting;
uniform float uKa, uKd;
uniform float uHeightScale;
uniform float uNormalScale;
uniform sampler2D uColorUnit;
uniform sampler2D uDispUnit;

in vec2 vST;
in vec3 vN;
in vec3 vL;

const float DELTA = 0.01;

void main( )
{
	vec3 newColor = texture( uColorUnit, vST ).rgb;
	gl_FragColor = vec4( newColor, 1. );

	if( uDoLighting )
	{
		vec2 stp0 = vec2( DELTA, 0. );
		vec2 st0p = vec2( 0. , DELTA );
		float west = texture2D( uDispUnit, vST-stp0 ).r;
		float east = texture2D( uDispUnit, vST+stp0 ).r;
		float south = texture2D( uDispUnit, vST-st0p ).r;
		float north = texture2D( uDispUnit, vST+st0p ).r;
		vec3 stangent = vec3( 2.*DELTA, 0., uNormalScale * ( east - west ) );
		vec3 ttangent = vec3( 0., 2.*DELTA, uNormalScale * ( north - south ) );
		vec3 Normal = normalize( cross( stangent, ttangent ) );
		vec3 Light = normalize(vL);
		vec3 ambient = uKa * newColor;
		float d = 0.;
		
		if( dot(Normal,Light) > 0. ) // only do diffuse if the light can see the point
		{
			d = dot(Normal,Light);
		}
		
		vec3 diffuse = uKd * d * newColor;
		gl_FragColor = vec4( ambient+diffuse, 1. );
	}
}