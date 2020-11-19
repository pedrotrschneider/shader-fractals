/*
(PT - Br) Documentação em português começa na linha 6.
(En) English documentation starts on line 30.

(PT - Br)
Documentação em português:
Este é um shader voltado para a renderização matemática do Triângulo de Sierpinski, um conhecido fractal
definido por uma regra de substituição geométrica descoberto por Waclaw Sierpinski.

Para a construção desse shader foram utilizadas diversas fontes:
- The Art of Code: https://www.youtube.com/channel/UCcAlTqd9zID6aNX3TzwxJXg
- The Coding Train: https://www.youtube.com/channel/UCvjgXvBlbQiydffZU7m1_aw
- Sebastian Lague: https://www.youtube.com/user/Cercopithecan

Este shader está sob a licença MIT.
Cheque "License.txt" para detalhes sobre a licensa.

Caso não queira compilar este shader você mesmo, siga esse link para ver ele funcionando:
<este link não existe ainda, será adicionado nos próximos dias>

Instruções para compilar:
- Entre no site https://www.shadertoy.com
- No canto superior direito, clique em "new". Você será redirecionado para uma página com uma caixa
de texto onde voce pode escrever e uma tela.
- Apague todo o conteúdo da caixa de texto.
- Copie este código e cole-o diretamente na ciaxa de texto.
- Se nada mudar, aperte "alt" + "enter" e o shader deve compilar.

(En)
English documentation:
This shader targets to achieve a mathematical render of Sierpinski's Triangle, a well known fractal
defined by a rule of geometrical substitution discovered by Waclaw Sierpinski.

For the creation of this shader, several resources were used:
- The Art of Code: https://www.youtube.com/channel/UCcAlTqd9zID6aNX3TzwxJXg
- The Coding Train: https://www.youtube.com/channel/UCvjgXvBlbQiydffZU7m1_aw
- Sebastian Lague: https://www.youtube.com/user/Cercopithecan

This shader in under the MIT license.
Refer to "LICENSE.txt" for the details of the license.

If you don't want to compile this shader yourself, you can follow this link to see it working:
<this link does not exist yet, but will be added in the following days>

Instructions to compile:
- Follow this url: https://www.shadertoy.com.
- On the upper right portion of the screen, click on the "new" button. You will be redirected to a page
with a text box you can write on and a screen.
- Delete all the text on the text box.
- Copy this code and paste it on the text box.
- If nothing happnes, press "alt" + "enter" and the shader should compile.
*/

#define PI 3.141592653589793238

// Returns a normalized directoin based on an angle
vec2 polarToCartesian (float angle) {
  return vec2 (sin (angle), cos (angle));
}

// Reflects the UV based on a relfection line centered in the point p with a given angle
vec2 ref (vec2 uv, vec2 p, float angle) {
  vec2 dir = polarToCartesian (angle); // Direction of the reflection line
  return uv - dir * min (dot (uv - p, dir), 0.0) * 2.0; // Returns the reflected uv coordinate
}

// Returns the signed distance of a point p to a equilateral triangle centered on the screen
float sigendDistTriangle (vec2 p) {
  const float sqrt3 = sqrt (3.0);
  p.x = abs (p.x) - 1.0;
  p.y = p.y + 1.0 / sqrt3;
  if (p.x + sqrt3 * p.y > 0.0) {
    p = vec2 (p.x - sqrt3 * p.y, -sqrt3 * p.x - p.y) / 2.0;
  }
  p.x -= clamp (p.x, -2.0, 0.0);
  return -length (p) * sign (p.y);
}

// Folds the 2d space to generate the fractal and returns the distance to it
float sierpinskiTriangle (inout vec2 uv, int recursionCount) {
  float scale = 0.9; // Scale of the UV
  uv *= scale; // Scales the UV to make the fractal fit on the screen
  for (int i = 0; i < recursionCount; ++i) {
    scale *= 2.0;
    uv *= 2.0; // Scales down the fractal
    uv.y -= 2.0 * sqrt (3.0) / 3.0; // Translates the fractal to the new Y position (sends it to the top)
    uv.x = abs (uv.x); // Makes a reflection plane on the Y axis
    uv = ref (uv, vec2 (1.0, -sqrt (3.0) / 3.0), (11.0 / 6.0) * PI); // Makes a reflection plane on the bototm right vertex of the triangle, with an angle of 330°
  }

  float d = sigendDistTriangle (uv) / scale; // Calculates de tistance to an equilateral triangle centered on the center of the screen
  uv /= scale; // Resets the scale of the uv
  return d; // Returns the distance to the triangle
}

void mainImage (out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = 2.0 * (fragCoord - 0.5 * iResolution.xy) / iResolution.y; // Normalized pixel coordinates (from 0 to 1)
  vec2 uv2 = uv; // Creates a copy of the uvs for coloring

  vec3 col = vec3 (0.0); // Color to be drawn on the screen

  uv += vec2 (0.0, 0.30); // Offsets the uvs to center the fractal in the middle of the screen

  int recursionCount = 0 + int (mod (iTime, 16.0) * 0.5); // Number of iterations of the fractal (increases with time)

  float d = sierpinskiTriangle (uv, recursionCount); // Distance to the fractal

  // Coloring the fractal
  float lineSmoothness = 3.0 / iResolution.y; // Smoothness of the line (higher number = smoother, lower numbers = sharper)
  float offset = 0.5; // Offset for the blending of the colors in the middle
  // Red channel
  float r = smoothstep (lineSmoothness, 0.0, d) * 0.5 * (uv2.x * 0.5 + 0.5 + offset); // Generates a gradient of red on the positive x axis
  col.r += r;
  // Blue channel
  float b = smoothstep (lineSmoothness, 0.0, d) * 0.5 * (uv2.y * 0.5 + 0.5 + offset); // Generates a gradient of blue on the positive y axis
  col.b += b;
  // Green channel
  float g = smoothstep (lineSmoothness, 0.0, d) * 0.5 * (-uv2.x * 0.5 + 0.5 + offset); // Generates a gradient of green on the negative x axis
  col.g += g;

  // Drawing the axis
  lineSmoothness = 2.0 / iResolution.y; // Descreases line smoothness for sharper / thinner lines
  col.rb += smoothstep (lineSmoothness, 0.0, length (uv.y)); // x axis
  col.bg += smoothstep (lineSmoothness, 0.0, length (uv.x)); // y axis

  fragColor = vec4 (col.rgb, 1.0); // Outputs the result color to the screen
}