function matr=analyse(f)
matr=length(f.players);
for i=1:length(f.games)
    [~,girls(i)]=f.cost_of_selection(f.games{i});
end

for i=1:length(f.players)
    for j=1:length(f.players)
        matr(i,j)=f.players{i}.played_with(j);
        g_av(i)=sum(f.players{i}.g_available);
        if(matr(i,j)==0)
            disp(strcat('Players',{' '}, f.players{i}.name ,' and ',{' '},f.players{j}.name, ' not playing together'));
        end
    end
end
%close all
fg=figure;
bar(girls)
fp=figure;
hold on;
bar(g_av)
bar(diag(matr))
fp.Children(1).XTickLabelRotation=45;
fp.Children(1).XTick=1:f.n_members;
for i=1:f.n_members
    fp.Children.XTickLabel{i}=f.members(i,2);
end

end