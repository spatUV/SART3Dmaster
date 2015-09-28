N = 40;
R = 1.75;
angle = (0:32-1)*(360/32);
offset = (360/32)/2;
angle = -(angle+offset);
coords = [R*ones(32,1), angle.', zeros(32,1)];
conf.LS.coord = cell(1,N);
for n=1:32
    conf.LS.coord{n} = coords(n,1:3);
end

conf.LS.coord{33} = [R, 45, 45];
conf.LS.coord{34} = [R, -45, 45];
conf.LS.coord{35} = [R, -135, 45];
conf.LS.coord{36} = [R, 135, 45];
conf.LS.coord{37} = [R, 45, -45];
conf.LS.coord{38} = [R, -45, -45];
conf.LS.coord{39} = [R, -135, -45];
conf.LS.coord{40} = [R, 135, -45];

conf.driver.ChannelMapping = 1:1:40;