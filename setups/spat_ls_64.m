N = 64;
R = 1.75;
angle = (0:N-1)*(360/N);
offset = (360/N)/2;
angle = -(angle+offset);
coords = [R*ones(N,1), angle.', zeros(N,1)];
conf.LS.coord = cell(1,N);
for n=1:N
    conf.LS.coord{n} = coords(n,1:3);
end
conf.driver.ChannelMapping = 1:1:64;