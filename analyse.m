function matr=analyse(f)
matr=length(f.players);
total_cost=0;
for i=1:length(f.games)
    [cost,girls(i)]=f.cost_of_selection(f.games{i});
    total_cost=total_cost+cost;
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
close all
fg=figure;
bar(girls)
title('Number of girls per game')
xlabel('Game')
fp=figure;
hold on;
bar(g_av)
bar(diag(matr))
fp.Children(1).XTickLabelRotation=45;
fp.Children(1).XTick=1:f.n_members;
for i=1:f.n_members
    fp.Children.XTickLabel{i}=strcat(f.members(i,1),'-',f.members(i,2));
end
l=legend('Available','Selected');
l.Orientation='horizontal';
ylabel('Games')

fi=figure;
imagesc(matr)
cm=jet;
cm(1,:)=[1,1,1];
cm=colormap(cm);

fi.Children(1).XTickLabelRotation=45;
fi.Children(1).XTick=1:f.n_members;
for i=1:f.n_members
    fi.Children.XTickLabel{i}=strcat(f.members(i,1),'-',f.members(i,2));
end
fi.Children(1).YTick=1:f.n_members;
for i=1:f.n_members
    fi.Children.YTickLabel{i}=f.members(i,2);
end
title('Combination of players')
colorbar

fa=figure;
imagesc(f.avail_grid(:,2:end));
hold on
fa.Children(1).YTick=1:f.n_members;
for i=1:f.n_members
    fa.Children.YTickLabel{i}=strcat(f.members(i,1),'-',f.members(i,2));
end
%title('Games')
for i=1:10
    t=text(i-0,0,['G', mat2str(i)]);
    t.HorizontalAlignment='center';
    plot(ones(1,length(f.games{i}))*i,f.games{i},'rx','MarkerSize',8);
end
fa.Children(1).XTick=1:10;
fa.Children(1).XTickLabel=sum(f.avail_grid(:,2:end));
xlabel('Available players')
total_cost
end