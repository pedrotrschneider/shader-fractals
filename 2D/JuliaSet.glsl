/*
(PT - Br) Documentação em português começa na linha 6.
(En) English documentation starts on line 30.

(PT - Br)
Documentação em português:
Este é um shader voltado para a renderização matemática de fractais do Conjunto de Julia, tratando-se de
um subconjunto do Conjunto de Mandelbrot.

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
This shader targets to achieve a mathematical render of Julia's Set fractals, beeing a subset of the
well known Mandelbrot Set.

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

#define RECURSION_LIMIT 10000.0
#define PI 3.141592653589793238

// Method for the mathematical construction of the julia set
float juliaSet (vec2 c, vec2 constant) {
  float recursionCount = 0.0;

  vec2 z = c;

  for (float i = 0.0; i < RECURSION_LIMIT; i++) {
    z = vec2 (z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + constant;

    if (length (z) > 2.0) {
      break;
    }

    recursionCount++;
  }

  return recursionCount;
}

// Main method of the sahder
void mainImage (out vec4 fragColor, in vec2 fragCoord) {
  const vec2[6] constants = vec2[] (
    vec2 (-0.7176, -0.3842),
    vec2 (-0.4, -0.59), // <-- !!!!!!
    vec2 (0.34, -0.05), // <-- !!!!!!
    vec2 (0.355, 0.355), // <-- !!!!!!
    vec2 (-0.54, 0.54),
    vec2 (0.355534, -0.337292)
  );

  vec2 uv = 2.0 * (fragCoord - 0.5 * iResolution.xy) / iResolution.y; // Normalized pixel coordinates (from 0 to 1)
  vec2 uv2 = uv; // Creates a copy of the uvs for coloring
  vec3 col = vec3 (1.0); // Color to be drawn on the screen

  float a = PI / 3.0; // rotation angle [rad]
  vec2 U = vec2 (cos (a), sin (a)); // U basis vector (new x axis)
  vec2 V = vec2 (-U.y, U.x); // V basis vector (new y axis)
  uv = vec2 (dot (uv, U), dot (uv, V)); // Rotationg the uv
  uv *= 0.9;

  vec2 c = uv;
  float recursionCount = juliaSet (c, constants[3]);
  float f = recursionCount / RECURSION_LIMIT;

  float offset = 0.5;
  vec3 saturation = vec3 (1.0, 1.0, 1.0);
  float totalSaturation = 1.0;
  float ff = pow (f, 1.0 - (f * 1.0));
  col.r = smoothstep (0.0, 1.0, ff) * (uv2.x * 0.5 + 0.3);
  col.b = smoothstep (0.0, 1.0, ff) * (uv2.y * 0.5 + 0.3);
  col.g = smoothstep (0.0, 1.0, ff) * (-uv2.x * 0.5 + 0.3);
  col.rgb *= 5000.0 * saturation * totalSaturation;

  fragColor = vec4 (col.rgb, 1.0); // Outputs the result color to the screen
}