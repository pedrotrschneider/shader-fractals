/*
(PT - Br) Documentação em português começa na linha 6.
(En) English documentation starts on line 31.

(PT - Br)
Documentação em português:
Este é um shader voltado para a renderização matemática do Conjunto de Mandelbrot, um dos fractais mais
conhecidos e utilizados na matemática. Ele é definido por uma função matemática no conjunto dos números
complexos.

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
This shader targets to achieve a mathematical render of Mandelbrot's Set, one the best known and most
used fractals in mathematics. It is defined by a mathematical function on the complex plane.

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

Instructions to compile:
- Follow this url: https://www.shadertoy.com.
- On the upper right portion of the screen, click on the "new" button. You will be redirected to a page
with a text box you can write on and a screen.
- Delete all the text on the text box.
- Copy this code and paste it on the text box.
- If nothing happnes, press "alt" + "enter" and the shader should compile.
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