# Estruturas fractais construídas com GLSL e feitas com matemática

[![forthebadge](https://forthebadge.com/images/badges/contains-tasty-spaghetti-code.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/60-percent-of-the-time-works-every-time.svg)](https://forthebadge.com)

Um repositório contendo diversos shaders em GLSL que renderizam fractais em duas e três dimensões.

- [Fractais 2D](#fractais-2d)
  - [Triângulo de Sierpinski](#triângulo-de-sierpinski)
  - [Carpete de Sierpinski](#carpete-de-sierpinski)
  - [Curva de Koch](#curva-de-koch)
  - [Conjunto de Mandelbrot](#conjunto-de-mandelbrot)
  - [Conjunto de Julia](#conjunto-de-julia)
- [Fractais 3D](#fractais-3D)
  - [Tetraedro de Sierpinski](#tetraedro-de-sierpinski)
  - [Esponja Menger](#esponja-de-menger)
  - [Brócolis de Menger](#brócolis-de-menger)
  - [Cogumelo de Menger](#cogumelo-de-menger)
  - [Mandelbulb](#-mandelbulb)
  - [Mandelbox](#-mandelbox)

## Fractais 2D

### Triângulo de Sierpinski

![gif](./media/sierpinski_trianlge.gif)

📌 Este fractal foi descrito pelo matemático polonês Waclaw Sierpinski em 1915, antes mesmo do termo "fractal" ser usado pela primeira vez. Este provavelmente é um dos fractais mais conhecidos.

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=\log_{2}{3} = 1,58496..."/>

🎨Para construir um Triângulo de Sierpinski você pode seguir os seguintes passos:
<br/>
1. Comece com um triângulo em um plano (canonicamente, foi utilizado um triângulo equilátero, mas esses processo pode ser feito utilizando qualquer tipo de triângulo).
2. Diminua o tamanho do triângulo até que seus lados tenham metade do tamanho original e faça três cópias do triângulo menor, dispondo-as de forma que cada uma encoste em um vértice das outras.
3. repita o passo 2 para cada nove figura formada infinitas vezes e você terá o fractal!

A primeira iteração deste loop resultará em um triângulo de nível 1, a segunda resultará em um triângulo de nível 2, e assim por diante. O Triângulo de Sierpinski é o resultado de infinitas iterações.

### Carpete de Sierpinski

![gif](./media/sierpinski_carpet.gif)

📌 Este fractal foi descrito pelo mesmo Waclaw Sierpinski que desenvolveu o Triângulo de Sierpinski. Essa é uma crição menos conhecida do matemático.
<br/>
É uma generalização bidimensional do fractal unidimensional do Conjunto de Cantor

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=\log_{2}{8} = 1,8928..."/>

Para construir um Carpete de Sierpinski você pode seguir os seguintes passos:
<br/>
1. Comece com um quadrado em um plano.
2. Divida-o em 9 quadrados iguais e remova o quadrado menor central, de forma que sobrem os 8 quadrados menores laterais.
3. Repita o passo 2 infinitas vezes para todos os quadrados em cada iteração e você terá o fractal!

A primeira iteração deste loop resultará em um carpete de nível 1, a segunda resultará em um carpete de nível 2, e assim por diante. O Carpete de Sierpinski é o resultado de infinitas iterações.

### Curva de Koch

![gif](./media/koch_curve.gif)

📌 Este fractal foi demosntrado pela primeira vez em 1904 em um artigo chamado "Em uma Curva Contínua Sem Tangentes, Que Pode Ser Construída Com Matemática Elementar", pelo matempatico sueco Helge Von Koch.

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=\log_{2}{4} = 1,26186..."/>

Para construir uma Curva de Koch você pode seguir os seguintes passos:
<br/>
1. Comece com um segmento de reta ou um triângulo equilátero. Agora, repita os próximos passos recursivamente para cada segmento de reta desenhado.
2. Divida o segmento de reta em três segmentos de linha de comprimentos iguais.
3. Use o segmento de reta menor como a base de um triângulo equilátero que aponta para fora (caso tenha utilizado um triângulo equilátero; se não, escolha uma direção para ser "para fora").
4. Remova o segmento de reta usado como base do novo triângulo desenhado.
5. Repita os passos de 2 a 4 infinitas vezes para cada segmento de reta e você terá o fractal!

A primeira iteração deste loop resultará em uma curva de nível 1, a segunda resultará em uma curva de nível 2, e assim por diante. A Curva de Koch é o resultado de infinitas iterações.

### Conjunto de Mandelbrot

![gif](./media/mandelbrot_set.gif)

📌 Este fractal é definido como um conjunto de números c no plano dos complexos que obedecem uma certa regra. É um dos fractais mais famosos e mais estudados que conhecemos. Ele foi investigado pela primeira vez no comço do século XX pelos matemáticos franceses Pierre Fatou e Gaston Julia.
<br/>
Ele foi definido e desenhado pela primeira vez por Robert W. Brooks e Peter Matelski em 1978, como parte de um estudo sobre grupos Kleinianos.
<br/>
No entanto, seu nome veio da pessoa que plotou uma visualização do conjunto em um computador, Benoit Mandelbrot, no dia 1° de março de 1980, na divisão de pesquisa da IBM (International Buisiness Machines Corporation). Ele também foi responsável pelo estudo de vários outros tópicos relacionados a geometria fractal.
<br/>
Estudos matematicos formais do conjunto de Mandelbrot começaram apenas em 1985, com os trabalhos dos matemáticos Adrien Douady e John H. Hubbard, que estabeleceram várias de suas propriedades fundamentais, e finalmente nomearam o fractal em homenagem a Benoit Mandelbrot por seus trablahos influenciais em geometria fractal.

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=2"/>

🎨 A forma mais fácial de criar uma visualização do conjunto de Mandelbrot é plotando em um computador, usando operações por pixel. Para fazer isso, você pode converter um número complexo c = a + bi para coordenadas de pixel, onde "a" é a posição do pixel no eixo X e "b" é a posição do pixel no eixo Y.
<br/>
Um número complexo c pertence ao conjunto de mandelbrot se a função:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;f_{c}(z)=z^2+c"/>

não diverge com z começando na origem quando iterada infinitas vezes.
<br/>
Aplicando esta recursão para cada número complexo correspondente a cada pixel de uma imagem, e colorindo os pixels baseado na quantidade de iterações que levou para eles divergirem, é possível conseguir uma figura semelhante à mostrada no vídeo.
<br/>
É recomendado que as coordenadas de pixel sejam normalizadas de modo que não excedam |2| em nenhum eixo, já que o conjunto de Mandelbrot está contido em um cículo de raio 2.

### Conjunto de Julia

![screenshot](./media/julia_set_1.png)
![screenshot](./media/julia_set_2.png)
![screenshot](./media/julia_set_3.png)

📌 Definimos:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;f_{c}(z)=z^2+c"/>

onde z e c são números no plano dos complexos. O conjunto de Julia pode ser então definido como o conjunto de números complexos z que, sob iteração em f<sub>c</sub> não divergem.
<br/>
c pode ser qualquer número complexo, mas deve permanecer constante após ser escolhdio para cada fractal. Para cada c diferente, há um conjunto diferente de z's que seguem a regra descrita.
<br/>
O conjunto foi nomeado em homenagem ao matemático francês Gaston Julia.

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=2"/>

🎨 O conjunto de Julia não pode ser plotado como uma única imagem, devido ao infinito número de possibilidades para a escolha de c. Portanto, o primeiro passo é escolher um valor para c.
<br/>
O resto do processo é essencialmente o mesmo ao do conjunto de Mandelbrot: transformando os números complexos em coordenadas de pixels, você pode iterar f<sub>c</sub> para o número complexo correspondente a cada pixel na imagem, e colorir eles baseado no número de iterações que ele levou para divergir.
<br/>
As coordenadas de pixel para o conjunto de Julia também devem ser normalizadas para não ultrapassarem |2| em nenhum eixo, assim como no conjunto de Mandelbrot.
<br/>
Mudando o valor do complexo c escolhido, pode-se mudar a imagem resultante. Curiosamente, se c ∈ conjunto de Mandelbrot, o fractal de Julia correspondente será uma forma sólida (veja a imagem 2), e, se c ∉ conjunto de Mandelbrot, o fractal de Julia correspondente não será apenas uma forma sólida, mas um conjunto de formas sem ligação uma com a outra (veja imagem 1).

## Fractais 3D

### Tetraedro de Sierpinski

![gif](./media/sierpinski_tetrahedron.gif)

📌 Este fractal é o análogo em três dimensões do Triângulo de Sierpinski. Ele também é conhecido como Tetrix.

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=\log_{2}{4}=2"/>

🎨 A construção de um Tetrix é muito similar ao do Triângulo de Sierpinski:
<br/>
1. Comece com um tetraedro de lado L.
2. Diminua seu tamanho até que a altura seja metade da original.
3. Faça quatro cópias do tetraedro menor, e disponha eles de forma que cada um toque os outros em um vértice.
4. Repita os passos 2 e3 para cada nova forma em cada iteração.

A primeira iteração deste loop resultará em um tetraedro de nível 1, a segunda resultará em um tetraedro de nível 2, e assim por diante. O Tetraedro de Sierpinski é o resultado de infinitas iterações.

Um fractal similar pode ser construído utilizando uma pirâmide de base quadrada como sua base.

### Esponja de Menger

![gif](./media/menger_sponge.gif)

📌 Este fractal é uma generalização tridimensional do bidimensional Carpete de Sierpinski, e, por consequência, também é uma generalização do unimensional Conjunto de Cantor. Ele foi descrito pela primeira vez por Karl Menger em 1925, durante seus estudos sobre dimensões topológicas.

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=\log_{3}{20}=2,7268..."/>

🎨 Uma Esponja de Menger pode ser construída com os seguintes passos:
<br/>
1. Comece com um cubo.
2. Divida cada face do cubo em 9 quadrados iguais, como em um cubo mágico. Isso irá dividir o cubo inicial em 27 cubos menores.
3. Remova os cubos menores do centro de cada face, e do centro do cubo maior (resultando em um total de 20 cubos).
4. Agora, repita os passos 2 e 3 para cada cubo menor formado com cada iteração e você terá o fractal!

A primeira iteração deste loop resultará em uma esponja de nível 1, a segunda resultará em uma esponja de nível 2, e assim por diante. A Esponja de Menger é o resultado de infinitas iterações.

### Brócolis de Menger

![gif](./media/menger_brocolli.gif)

📌 Este não é um fractal canônico. Ele foi construído por mim enquanto brincava com o algoritimo usado para renderizar a Esponja de Menger. Ele foi chamado de Brócolis de Menger pois ele utiliza o mesmo algoritimo que a Esponja de Mneger, e ele também tem um formado parecido com uma couve ou um brócolis.
<br/>
Infelizmente, o algoritimo original que usei para fazer o vídeo foi perdido, e o que está neste repositório é apenas uma aproximação do fractal original (eu não consegui encontrar os parâmetros originais que usei para o vídeo).

🎨 A construção deste fractal será explicada com base no algoritimo, como não há nenhuma definição canônica de sua forma. Ele foi construído utlizando um SDF (Signed Distance Field) com ray-marching, e mais várias outras funções de alteração do espaço, como estão no shader.
<br/>
Há diversos ótimos recursos para aprender sobre estes conceitos, e eles são todos mencionados nas documentações espcíficas dos shaders. Para todos os fractais tridimensionais, os recursos usados foram:
<br/>
- Inigo Quilez: http://iquilezles.org​
- Sebastian Lague: https://www.youtube.com/user/Cercopithecan
- Code Parade: https://www.youtube.com/channel/UCrv269YwJzuZL3dH5PCgxUw

### Cogumenlo de Menger

![gif](./media/menger_mushroom.gif)

📌 Como o Brócolli de Mneger, eu construí esse fractal também baseado no memso algoritimo da Esponja de Menger. Na verdade, não se trata nem de apenas um fractal, mas sim de uma coleção de fractais que se transofrmam um no outro para gerar a animação. Ele foi chamado de Cogumelo de Menger também devido ao uso do mesmo algoritimo, e, por algum motivo, ele me lembrou de cogumelos, então ficou no nome.
<br/>
Diferente do que aconteceu como o Brócolis de Menger, o shader neste repositório é o original usado para gravar a animação.

🎨 A construção deste fractal será explicada com base no algoritimo, como não há nenhuma definição canônica de sua forma. Ele foi construído utlizando um SDF (Signed Distance Field) com ray-marching, e mais várias outras funções de alteração do espaço, como estão no shader.
<br/>
Há diversos ótimos recursos para aprender sobre estes conceitos, e eles são todos mencionados nas documentações espcíficas dos shaders. Para todos os fractais tridimensionais, os recursos usados foram:
<br/>
- Inigo Quilez: http://iquilezles.org​
- Sebastian Lague: https://www.youtube.com/user/Cercopithecan
- Code Parade: https://www.youtube.com/channel/UCrv269YwJzuZL3dH5PCgxUw

### Mandelbulb

![gif](./media/mandelbulb.gif)

📌 Este fractal foi definido pela primeira vez por Daniel White e Paul Nylander em 2009, usando coordenadas esféricas. Ele não é, no entanto, um correspondente tridimensional canônico para o Conjunto de Mandelbrot. Tal estrutura não existe, já que não há um correspondente tridimensional para o bidimensional plano do números complexos. É possível construir um Conjunto de Mandelbrot canônico em quatro dimensões usando quaternions e números bicomplexos, mas o Mandelbulb não se trata dele.

Ele possui dimensão fractal (de Hausdorff) de:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;D=3"/>

Isso, no entanto, foi apenas conjecturado, e ainda não foi provado.

🎨 O Mandelbulb é definido como um conjunto de pontos c no ℝ<sup>3</sup> que, sob iteração da função:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;f_{c}(v)=v^n+c"/>

com v começando em (0, 0, 0) não diverge.
<br/>
A n<sup>ésima</sup> potência do vetor v = (x, y, z)  no ℝ<sup>3</sup> é definida como:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;v^n:=r^n(\sin{(n\theta)}\cos{(n\phi)},\sin{(n\theta)}\sin{(n\phi)},\cos{(n\theta)})"/>

Onde:

<img src="https://latex.codecogs.com/svg.latex?\Large&space;r=\sqrt{x^2+y^2+z^2}"/>
<br/>
<img src="https://latex.codecogs.com/svg.latex?\Large&space;\theta=\arccos{\frac{z}{y}}"/>
<br/>
<img src="https://latex.codecogs.com/svg.latex?\Large&space;\phi=\arctan{\frac{z}{r}}"/>

O Mandlebulb mostrado no vídeo foi construído com n = 8. Diferentes valores de n resultam em diferentes estruturas. O efeito fluido no vídeo foi feito variando as coordenadas esféricas de cada ponto da forma continuamente.
<br/>
Possivelmente a maneira mais comum de construir este fractal é utlizando técnicas como ray-tracing ou ray-marching (como foi usado no shader deste fractal).

### Mandelbox

![gif](./media/mandelbox.gif)

📌 Um Mandelbox não se trata de um fractal específico, diferente da maioria dos fractais tratados até agora. Ele pode ter diversas formas diferentes, mas, de forma geral, pode ser descrito como um fractal com uma forma de caixa, e foi encontrado pela primeira vez por Tom Lowe in 2010.
<br/>
Ele é similar ao Conjunto de Mandelbrot da mesma forma que o Mandelbulb: ele é definido com um conjunto de valores de um parâmetro para os quais a origem (em ℝ<sup>3</sup>, (0, 0, 0)) não diverge sob iteração infinita de um certa transformação geométrica. Ele pode também ser definido como uma junção de Conjuntos de Julia continuos, mas, diferente do Conjunto de Mandelbrot, pode ser generalizado para qualquer dimensão.

🎨 O Mandelbox é definido como um conjunto de pontos no espaço que não divergem sob a seguinte iteração:
```python
function iterate(z):
  foreach component in z:
    if component > 1:
      component = 2 - component
    else if component < -1:
      component = -2 - component

  if |z| < 0.5:
    z = z * 4
  else if |z| < 1:
    z = z / (|z|^2)

  z = scale * z + c
```
Neste caso, c é o ponto sendo testado, e "scale" é uma constante real que pode ser escolhida no começo da processo iterativo para mudar a forma final do fractal.

Estes são todos os fractais presentes neste repositório. Agradeço a todos os donos dos recursos que foram citados tanto neste documento quanto na documentação específica de cada shader. E por fim, obrigado por ler!