/**
 * @file MandelbrotSet.glsl
 *
 * @brief This shader targets to achieve a mathematical render of Mandelbrot's Set, one the best known and most
 * used fractals in mathematics. It is defined by a mathematical function on the complex plane.
 *
 * @author Pedro Schneider <pedrotrschneider@gmail.com>
 *
 * @date 06/2020
 *
 * Direct link to ShaderToy: <not available yet>
*/

// Method for the mathematical constructoin of the mandelbrot set
float mandelbrot (vec2 c, float RECURSION_LIMIT) {
  float recursionCount = 0.0;

  vec2 z = vec2 (0.0, 0.0);

  for (float i = 0.0; i < RECURSION_LIMIT; i++) {
    z = vec2 (z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;

    if (length (z) > 2.0) {
      break;
    }

    recursionCount++;
  }

  return recursionCount;
}

void mainImage (out vec4 fragColor, in vec2 fragCoord) {
  const vec2[4] locations = vec2[] (
    vec2 (0.281717921930775, 0.5771052841488505),
    vec2 (-0.81153120295763, 0.20142958206181),
    vec2 (0.452721018749286, 0.39649427698014),
    vec2 (-0.745428, 0.113009) // <-- this is the one used in the demonstration. You can change the
                               // index of the array on line XX to change the final location
  );

  vec2 uv = 2.0 * (fragCoord - 0.5 * iResolution.xy) / iResolution.y; // Normalized pixel coordinates (from 0 to 1)
  vec2 uv2 = uv; // Creates a copy of the uvs for coloring
  vec2 mouse = iMouse.xy / iResolution.xy; // Gets the coordinates of the mouse to aply zoom

  float time = 0.032 * float (iFrame);
  // float time = iTime;
  float zoom = pow (time, time / 10.0);
  vec3 col = vec3 (1.0); // Color to be drawn on the screen

  float RECURSION_LIMIT = 10000.0; // Maximum number of iterations to test

  uv /= (zoom); // Scales the uv based of the zoom
  vec2 c = uv; // Initializes c as the current pixel position
  c += locations[3]; // Offsets the current pixel position to put the desired location in the middle

  float recursionCount = mandelbrot (c, RECURSION_LIMIT); // Calculates the amount of iterations until the point went out of bounds

  float f = recursionCount / RECURSION_LIMIT; // Puts the amount of iterations in range [0, 1]

  // Coloring the fractal
  if (f == 1.0) { // If it is in the mandelbrot set itself, colors black
    col.r = 0.0;
    col.b = 0.0;
    col.g = 0.0;
  }
  else { // If its close to the mandelbrot set, colors based on how close it is to beeing on the mandelbrot
    float offset = 0.5;
    float ff = pow (f, 1.0 - (f * max (0.0, (50.0 - time))));
    float smoothness = 1.0;
    col.r = smoothstep (0.0, smoothness, ff) * (uv2.x * 0.5 + 0.5);
    col.b = smoothstep (0.0, smoothness, ff) * (uv2.y * 0.5 + 0.5);
    col.g = smoothstep (0.0, smoothness, ff) * (-uv2.x * 0.5 + 0.5);
  }

  fragColor = vec4 (col.rgb, 1.0); // Outputs the result color to the screen
}