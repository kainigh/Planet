#version 400 core

uniform float uLightX, uLightY, uLightZ;
uniform float uKa, uKd, uKs;
uniform bool  uFlat = false;
uniform vec3  uColor;

uniform float uLevel1, uLevel2, uTol;
uniform vec4 uSpecularColor;
uniform float uShininess;

/*in vec3 vNs;
in vec3 vLs;
in vec3 vEs;
in vec3 vMC;*/

const vec3 BLUE = vec3( 0.1, 0.1, 0.5 );
const vec3 GREEN = vec3( 0.0, 0.8, 0.0 );
const vec3 BROWN = vec3( 0.6, 0.3, 0.1 );
const vec3 WHITE = vec3( 1.0, 1.0, 1.0 );
const vec3 GRAY = vec3( 0.5, 0.5, 0.5 );

flat in vec3 gNormalF;
     in vec3 gNormalS;
     in vec3 gPosition;

layout(location=0) out vec4 FragColor;

void main( )
{
	vec3 lightPos = vec3( uLightX, uLightY, uLightZ );
	float lightIntensity  = dot( normalize( lightPos - gPosition ), uFlat ? gNormalF : gNormalS );
	FragColor = vec4(  ( uKa + uKd*lightIntensity ) * uColor.rgb, 1.  );
}

/*void
main( )
{
	vec3 Normal = vec3( 0., 0., 1. );
	vec3 color = BLUE;
	if( vMC.z > 0. )
	{
		float t = smoothstep( uLevel1-uTol, uLevel1+uTol, vMC.z);
		color = mix( GREEN, GRAY, t );
		Normal = normalize( vNs );
	}
	if( vMC.z > uLevel1+uTol )
	{
		float t = smoothstep( uLevel2-uTol, uLevel2+uTol, vMC.z);
		color = mix( GRAY, WHITE, t );
		Normal = normalize( vNs );
	}
	
	vec3 Light = normalize( vLs );
	vec3 Eye = normalize( vEs );
	vec3 ambient = uKa * color;
	float d = dot(Normal,Light);
	vec3 diffuse = uKd * d * color;
	float s = 0.;
	
	if( d > 0. ) // only do specular if the light can see the point
	{
		vec3 ref = normalize( 2. * Normal * dot(Normal,Light) - Light );
		s = pow( max( dot(Eye,ref),0. ), uShininess );
	}
	vec3 specular = uKs * s * uSpecularColor.rgb;
	gl_FragColor = vec4( ambient.rgb + diffuse.rgb + specular.rgb, 1. );
}*/
