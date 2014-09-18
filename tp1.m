screenNum =0;
res =[1024 768];
teclaApretada = [];
apariciones = [];
clrdepth=32;
[win,rect]=Screen('OpenWindow',screenNum,0,[0 0 res(1) res(2)], clrdepth);
black=BlackIndex(win);
white=WhiteIndex (win) ;
Screen('FillRect',win,black);
refresh = Screen('GetFlipInterval',win);
%Synchronize to retrace at start of trial/animation loop:
vbl = Screen('Flip', win);
% Loop : Cycle through 300 images :
%myImage=255*rand(100, 100);
%Screen(?FrameOval?, window, color, boundingrect [, penWidth]);
%Screen('MakeTexture', win, myImage);
%Screen('DrawTexture', win, textureIndex);


imagenesSubliminales = [];
imagenesSecundarias = [[]];
imagenesSubliminalesFruta = [];
imagenesSecundariasFruta = [[]];

wait_pl1 = 2;  % Tiempo que dura la primer pantalla para limpiar retina
wait_is = 0.50;   % Tiempo que se muestra la imagen subliminal
wait_pl2 = 2;  % Tiempo que dura la segunda pantalla para limpiar retina

imgsec_space = 20; % Tamanio en pixels para los espacios entre las imagenes secundarias


% Aviso de warning de mac
% Pantalla negra con la descripcion de la tarea:
% "A continuacion apareceran grupos de 3 imagenes. La tarea consiste en
% escribir una palabra que se relacione con ellas. 
% Debera oprimir la barra espaciadora recien cuando este listo para escribir la palabra.
% Presione una tecla para continuar."
% wait_init
Screen('FillRect',win,black);
Screen('Flip', win);
% TODO: mostrar descripcion

% Bucle i = 1:size(imagenesSubliminales)
% Preguntar: pantalla para limpiar retina
% wait_pl1
% Mostrar imagen subliminal
% wait_is
% Pantalla limpia-retina
% wait_pl2
% Imagenes secundarias
% Comenzar a medir tiempo
% wait barra espaciadora
% Input de texto para escribir
% wait enter
% Finalizar medicion de tiempo, guardar tiempo y respuesta


semaforo = 0;
tic
for i=1:1
    
    Screen('FillRect', win, white); % Limpia retina
    Screen('Flip', win);
    WaitSecs(wait_pl1);
    
    % Mostramos la imagen subliminal
    imsub=imread('test.png', 'png');
    Screen('PutImage', win, imsub);
    Screen('Flip', win);
    WaitSecs(wait_is);
    
    Screen('FillRect', win, white); % Limpia retina
    Screen('Flip', win);
    WaitSecs(wait_pl2);
    
    % Mostramos imagenes secundarias
    % Cargamos las imagenes
    imsec1=imread('test.png', 'png');
    imsec2=imread('test.png', 'png');
    imsec3=imread('test.png', 'png');
    
    % Obtenemos el alto mas grande de las tres imagenes
    max_height=max([size(imsec1,1); size(imsec2,1); size(imsec3,1)]);
    
    % Agregamos blanco necesario arriba y abajo a la primera imagen
    wadd=ones(floor((max_height-size(imsec1,1))/2), size(imsec1,2), 3)*255;
    padd=ones(mod(max_height-size(imsec1,1),2), size(imsec1,2), 3)*255;
    imsec1=[wadd; padd; imsec1; wadd];
    
    % Agregamos blanco necesario arriba y abajo a la segunda imagen
    wadd=ones(floor((max_height-size(imsec2,1))/2), size(imsec2,2), 3)*255;
    padd=ones(mod(max_height-size(imsec2,1),2), size(imsec2,2), 3)*255;
    imsec2=[wadd; padd; imsec2; wadd];
    
    % Agregamos blanco necesario arriba y abajo a la tercera imagen
    wadd=ones(floor((max_height-size(imsec3,1))/2), size(imsec3,2), 3)*255;
    padd=ones(mod(max_height-size(imsec3,1),2), size(imsec3,2), 3)*255;
    imsec3=[wadd; padd; imsec3; wadd];
    
    % Las pegamos
    space=ones(max_height,imgsec_space,3)*255;
    imsecs=[imsec1 space imsec2 space imsec3];
    size(imsecs)
    
    % Ponemos en pantalla y mostramos
    Screen('PutImage', win, imsecs);
    Screen('Flip', win);
    %TODO: Mensaje: "Presione una tecla cuando este listo para escribir la palabra..."
    
    % Esperamos hasta que el usuario toque una tecla
    pressed = 0;
    while pressed == 0
        [pressed, secs, kbData] = KbCheck;  
    end;
    %TODO: Como obtengo el tiempo aca?
    
    
    %TODO: Escribir palabra
    
    %Draw i?th image to backbuffer:
    %Screen('DrawTexture', win, textureIndex);
    %Show images exactly 2 refresh cycles apart of each other:
    %[down, secs, keycode]=KbCheck;
    WaitSecs(0.005);
    %Keyboard checks , whatever ... Next loop iteration .
end;
%End of animation loop , blank screen , record offset time :
%toffset = Screen('Flip', win, vbl + (2 - 0.5) * refresh);
toc

Screen('CloseAll');
ShowCursor;