clear all
if ~isempty(instrfind)
     fclose(instrfind);
     delete(instrfind);
end

s = serial('COM8'); % tao doi tuong giao tiep vo
s.Baudrate = 115200; % truyen voi toc do 1Mbps
s.DataBits = 8;
s.StopBits = 1;
s.Parity = 'none';
s.Timeout = 10; % 10 giay
s.InputBufferSize = 38400; % buffer luu anh QVGA
fopen(s); % ket noi COM8
% gui ky tu B den kit, yeu cau gui anh ve PC
% fprintf(s,'B');
% doc du lieu STM32F4 truyen ve qua USART1
out = fgetl(s);
A = double(out); % tra ket qua ve dang ma tran A
% chuyen doi du lieu ve thanh ma tran anh 160x240
image = zeros(160,240); % khoi tao bo dem anh
row =1; col = 1;
for i = 1:38400
image(row,col) = A(i);
if mod(i,240) == 0
row=row+1;
col = 0;
end
col=col+1;
end
% chuyen doi thanh kieu du lieu 8 bit, anh da muc xam
x=uint8(image);
imshow(x); % xem anh
fclose(s); % ngat ket noi
delete(s); % xoa doi tuong
clear all;