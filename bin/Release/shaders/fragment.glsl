﻿#version 440

// input
in vec3 TexCoord;
in vec3 EyeSun;
in vec3 EyePosition;
in vec3 EyeNormal;

// texture
uniform sampler2DArray uTexture;

// output
out vec4 outColor;

// phong lighting model
float PhongModel(vec3 position, vec3 normal) {
  vec3 v = normalize(-position);
  vec3 h = normalize(v + EyeSun);
  float sunDotNormal = max(dot(EyeSun, normal), 0.0);
  
  float ambient = 0.2;
  float diffuse = 0.8 * sunDotNormal;
  float specular = pow(max(dot(v, h), 0.0), 40.0) * 0.8;
  
  return ambient + diffuse + specular;
}

void main() {
  // calculate fog
  const float e = 2.71828182845904523536028747135266249;
  vec4 fogColor = vec4(0.7, 0.9, 1.0, 1.0);
  float fogDensity = 0.0025;
  float fog = pow(e, -pow(length(EyePosition) * fogDensity, 2));
  
  // calculate light
  float light = PhongModel(EyePosition, EyeNormal);
  
  // get texture color
  vec4 texColor = texture(uTexture, TexCoord);
  
  // calculate output
  outColor = mix(fogColor, texColor * light, fog);
}