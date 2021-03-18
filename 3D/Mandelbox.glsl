/**
 * @file Mandelbox.glsl
 *
 * @brief This shader targets to achieve a mathematical render of Mandelbrot's Box, a fractal based on the same
 * Mandelbrots's Formula used to construct the well known Mandelbrot's set.
 *
 * @author Pedro Schneider <pedrotrschneider@gmail.com>
 *
 * @date 06/2020
 *
 * Direct link to ShaderToy: <not available yet>
*/

#define MaximumRaySteps 2500
#define MaximumDistance 200.
#define MinimumDistance .001
#define PI 3.141592653589793238

// TRANSFORM FUNCTIONS //

mat2 Rotate (float angle) {
  float s = sin (angle);
  float c = cos (angle);

  return mat2 (c, -s, s, c);
}

vec3 R (vec2 uv, vec3 p, vec3 l, float z) {
  vec3 f = normalize (l - p),
    r = normalize (cross (vec3 (0, 1, 0), f)),
    u = cross (f, r),
    c = p + f * z,
    i = c + uv.x * r + uv.y * u,
    d = normalize (i - p);
  return d;
}

// Converts a color from the HSV colorspace to RGB
vec3 hsv2rgb (vec3 c) {
  vec4 K = vec4 (1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs (fract (c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix (K.xxx, clamp (p - K.xxx, 0.0, 1.0), c.y);
}

// SDF FUNCTIONS //
// SDF sphere
vec4 sphere (vec4 z) {
  float r2 = dot (z.xyz, z.xyz);
  if (r2 < 2.0)
    z *= (1.0 / r2);
  else z *= 0.5;

  return z;
}

// SDF box
vec3 box (vec3 z) {
  return clamp (z, -1.0, 1.0) * 2.0 - z;
}

float DE0 (vec3 pos) {
  vec2 m = iMouse.xy / iResolution.xy;
  vec3 from = vec3 (0.0);
  vec3 z = pos - from;
  float r = dot (pos - from, pos - from) * pow (length (z), 2.0);
  return (1.0 - smoothstep (0.0, 0.01, r)) * 0.01;
}

float DE2 (vec3 pos) {
  vec2 m = iMouse.xy / iResolution.xy;
  // vec3 params = vec3 (0.22, 0.5, 0.5);
  vec3 params = vec3 (0.5, 0.5, 0.5);
  vec4 scale = vec4 (-20.0 * 0.272321);
  vec4 p = vec4 (pos, 1.0), p0 = p;
  vec4 c = vec4 (params, 0.5) - 0.5; // param = 0..1

  for (float i = 0.0; i < 10.0; i++) {
    p.xyz = box (p.xyz);
    p = sphere (p);
    p = p * scale + c;
  }

  return length (p.xyz) / p.w;
}

float DE (vec3 pos) {

  float d0 = DE0 (pos);
  float d2 = DE2 (pos);

  return max (d0, d2);
}

// Marches the ray in the scene
vec4 RayMarcher (vec3 ro, vec3 rd) {
  float steps = 0.0;
  float totalDistance = 0.0;
  float minDistToScene = 100.0;
  vec3 minDistToScenePos = ro;
  float minDistToOrigin = 100.0;
  vec3 minDistToOriginPos = ro;
  vec4 col = vec4 (0.0, 0.0, 0.0, 1.0);
  vec3 curPos = ro;
  bool hit = false;

  for (steps = 0.0; steps < float (MaximumRaySteps); steps++) {
    vec3 p = ro + totalDistance * rd; // Current position of the ray
    float distance = DE (p); // Distance from the current position to the scene
    curPos = ro + rd * totalDistance;
    if (minDistToScene > distance) {
      minDistToScene = distance;
      minDistToScenePos = curPos;
    }
    if (minDistToOrigin > length (curPos)) {
      minDistToOrigin = length (curPos);
      minDistToOriginPos = curPos;
    }
    totalDistance += distance; // Increases the total distance armched
    if (distance < MinimumDistance) {
      hit = true;
      break; // If the ray marched more than the max steps or the max distance, breake out
    }
    else if (distance > MaximumDistance) {
      break;
    }
  }

  float iterations = float (steps) + log (log (MaximumDistance)) / log (2.0) - log (log (dot (curPos, curPos))) / log (2.0);

  if (hit) {
    col.rgb = vec3 (0.8 + (length (curPos) / 10.0), 1.0, 0.8);
    col.rgb = hsv2rgb (col.rgb);
  }

  col.rgb /= steps * 0.08; // Ambeint occlusion
  col.rgb /= pow (distance (ro, minDistToScenePos), 2.0);
  col.rgb *= 20.0;

  return col;
}

void mainImage (out vec4 fragColor, in vec2 fragCoord) {
  // Normalized pixel coordinates (from 0 to 1)
  vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
  //uv *= 1.5;
  vec2 m = iMouse.xy / iResolution.xy;

  vec3 ro = vec3 (0, 0, -2.0); // Ray origin
  ro.yz *= Rotate ((iTime * PI + 1.0) / 20.0); // Rotate thew ray with the mouse rotation
  ro.xz *= Rotate (iTime * 2.0 * PI / 10.0);
  vec3 rd = R (uv, ro, vec3 (0, 0, 1), 1.); // Ray direction (based on mouse rotation)

  vec4 col = RayMarcher (ro, rd);

  // Output to screen
  fragColor = vec4 (col);
}