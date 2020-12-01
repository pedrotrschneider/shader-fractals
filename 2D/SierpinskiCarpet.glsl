/**
 * @file SierpinskiCarpet.glsl
 *
 * @brief This shader targets to achieve a mathematical render of Sierpinski's Carpet, a fractal defined by a rule
 * of geometrical substituion. It was discovered by the same mathemathician that discovered the more famous
 * Sierpinski's Triangle fractal.
 *
 * @author Pedro Schneider <pedrotrschneider@gmail.com>
 *
 * @date 06/2020
 *
 * Direct link to ShaderToy: <not available yet>
*/

#define PI 3.141592653589793238

// Folds the 2d space to generate the fractal and returns the distance to it
float sierpinskiCarpet (inout vec2 uv, int steps) {
  float scale = 4.0; // Scale of the UV
  uv *= 4.0; // Scales the UV to make the fractal fit on the screen
  uv = abs (uv); // Creates a reflection line in each (X and Y) axis

  for (int i = 0; i < steps; ++i) {
    scale *= 3.0;
    uv *= 3.0;
    uv = abs (uv);
    uv *= 1.0 - step (uv.x, 3.0) * step (uv.y, 3.0);
    uv -= vec2 (0, 3);
    uv = abs (uv);
    uv -= vec2 (0, 3);
    uv = abs (uv);
    uv -= vec2 (3, 0);
    uv = abs (uv);
    uv -= vec2 (3, 0);
    uv = abs (uv);
  }

  float d = length (uv - vec2 (min (uv, vec2 (1)))) / scale;
  uv /= scale;
  return d;
}

// Main function of the shader
void mainImage (out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = 2.0 * (fragCoord - 0.5 * iResolution.xy) / iResolution.y; // Normalized pixel coordinates (from 0 to 1)
  vec2 uv2 = uv; // Creates a copy of the uvs for coloring

  vec3 col = vec3 (0.0); // Color to be drawn on the screen

  int recursionCount = 0 + int (mod (iTime, 12.0) * 0.5); // Number of iterations of the fractal (increases with time)

  float d = sierpinskiCarpet (uv, recursionCount); // Distance to the fractal

  // Coloring the fractal
  float lineSmoothness = 3.0 / iResolution.y; // Smoothness of the line (higher number = smoother, lower numbers = sharper)
  float offset = 0.5; // Offset for the blending of the colors in the middle
  // Red channel
  float r = smoothstep (lineSmoothness, 0.0, d) * 0.5 * (uv2.x * 0.5 + 0.5 + offset); // Generates a gradient of red on the positive x axis
  col.r = r;
  // Blue channel
  float b = smoothstep (lineSmoothness, 0.0, d) * 0.5 * (uv2.y * 0.5 + 0.5 + offset); // Generates a gradient of blue on the positive y axis
  col.b = b;
  // Green channel
  float g = smoothstep (lineSmoothness, 0.0, d) * 0.5 * (-uv2.x * 0.5 + 0.5 + offset); // Generates a gradient of green on the negative x axis
  col.g = g;

  // Drawing the axis
  lineSmoothness = 2.0 / iResolution.y; // Descreases line smoothness for sharper / thinner lines
  col.rb += smoothstep (lineSmoothness, 0.0, length (uv.y)); // x axis
  col.bg += smoothstep (lineSmoothness, 0.0, length (uv.x)); // y axis

  fragColor = vec4 (col.rgb, 1.0); // Outputs the result color to the screen
}