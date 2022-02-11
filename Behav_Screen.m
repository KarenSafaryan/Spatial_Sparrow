function Behav_Screen(path_to_data)

    % Upload the data
    load(path_to_data);
    
    % Register 
    [~, MtlbData_nm] = fileparts(path_to_data);
    Mice_Date = MtlbData_nm(22:29);
    Mice_Name = MtlbData_nm(1:5);
    Mice_Weight = SessionData.animalWeight;
    % Mice_Water = 
    
    fg = figure(1);
    set(fg, 'Position', [50 50 1100 900]);
    clf;   
    Label_a = {'a', 'b', 'c'};
    
    axes('Position', [0.1 0.72 0.4 0.225]);
    hold off;
    plot(SessionData.lPerformance, 'o-b', 'LineWidth', 1, 'MarkerSize', 4, 'MarkerEdge', 'b'); % , 'MarkerFace', 'b'
    hold on;
    plot(SessionData.rPerformance, 'o-m', 'LineWidth', 1, 'MarkerSize', 4, 'MarkerEdge', 'm'); % , 'MarkerFace', 'm'
    plot([0 SessionData.nTrials], [0.5 0.5], 'k-', 'LineWidth', 1);
    ylim([0 1]);
    xlabel('Trials (#)', 'FontSize', 20, 'FontWeight', 'Normal'); 
    ylabel('Performance', 'FontSize', 20, 'FontWeight', 'Normal');
    % axis(gca, 'square');
    xlim([0 SessionData.nTrials]);
    set(gca,'color','none', 'TickDir', 'out');     
    set(gca,'TickLength', [0.01 0.025]*1.5);    
    set(gca, 'FontSize', 14, 'FontWeight', 'Normal', 'Box', 'off');   
    [lg,icons] = legend('Left Spout', 'Right Spout');
    icons(5).XData = [icons(5).XData(1)+(diff(icons(5).XData)/1.7) icons(5).XData(2)];
    icons(3).XData = [icons(3).XData(1)+(diff(icons(3).XData)/1.7) icons(3).XData(2)];
    icons(1).FontSize = 13;
    icons(2).FontSize = 13;
    icons(2).Color = 'm';
    icons(1).Color = 'b';
    icons(3).delete;
    icons(5).delete;
    set(lg, 'Box', 'off', 'FontSize', 15);
    set(lg, 'location', 'south');
    text(min(get(gca, 'xlim'))-0.125*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))),...
        'a', 'FontSize', 20, 'FontWeight', 'Bold');
    % text(350, 0.45, sprintf('Date %s', Mice_Date,), 'FontSize', 12, 'FontWeight', 'Normal');
    
%     Delay_Periods = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.DelayPeriod), 1:SessionData.nTrials);
%     StimulusCue = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.StimulusCue), 1:SessionData.nTrials);
%     PlayStimulus = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.PlayStimulus), 1:SessionData.nTrials); 
    WaitForResponse = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.WaitForResponse(1, :)), 1:SessionData.nTrials);
%     CheckReward = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.CheckReward(1, :)), 1:SessionData.nTrials);
%     Reward = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.Reward), 1:SessionData.nTrials);
%     HappyTime = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.HappyTime), 1:SessionData.nTrials);
%     MoveSpout = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.MoveSpout), 1:SessionData.nTrials);
%     TrialEnd = arrayfun(@(x) diff(SessionData.RawEvents.Trial{x}.States.TrialEnd), 1:SessionData.nTrials);
%     Trial_time = SessionData.TrialEndTimestamp-SessionData.TrialStartTimestamp;
    
    axes('Position', [0.575 0.72 0.35 0.225]);
    hold off;
    plot(1:numel(SessionData.CorrectSide), SessionData.CorrectSide, 'ok', 'MarkerSize', 4, 'MarkerFace', 'none', 'MarkerEdge', 'k');
    hold on;
    green_trials = SessionData.ResponseSide==SessionData.CorrectSide;
    plot(find(green_trials), SessionData.ResponseSide(green_trials), 'og', 'MarkerSize', 4, 'MarkerFace', 'g', 'MarkerEdge', 'g');
    plot(find(~green_trials), SessionData.ResponseSide(~green_trials), 'or', 'MarkerSize', 4, 'MarkerFace', 'r', 'MarkerEdge', 'r');
    ylim([0 3]);
    xlim([0 SessionData.nTrials]);
    set(gca, 'YTick', [1 2], 'YTickLabel', {'Right', 'Left'}, 'FontSize', 10, 'FontWeight', 'Normal');
    ytickangle(90);
    set(gca,'color','none', 'TickDir', 'out');     
    set(gca,'TickLength', [0.01 0.025]*1.5);    
    set(gca, 'FontSize', 14, 'FontWeight', 'Normal', 'Box', 'off');   
    xlabel('Trials (#)', 'FontSize', 14, 'FontWeight', 'Normal'); 
    title(sprintf('Date: %s \nMice: %s Weight: %0.1f', Mice_Date, Mice_Name, Mice_Weight), 'FontSize', 12, 'FontWeight', 'Normal');
    text(min(get(gca, 'xlim'))-0.125*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))),...
        'b', 'FontSize', 20, 'FontWeight', 'Bold');
    
    axes('Position', [0.1 0.1 0.35 0.5]);
    hold off;
    for tr = 1:SessionData.nTrials
        if(isfield(SessionData.RawEvents.Trial{tr}.Events, 'TouchShaker1_1'))         
            licktime = SessionData.RawEvents.Trial{tr}.Events.TouchShaker1_1; % -(SessionData.TrialStartTime(tr)*0.001);
            plot( licktime, tr*ones(1, numel(licktime)), '.b', 'MarkerSize', 2);
            hold on;
        end

        if(isfield(SessionData.RawEvents.Trial{tr}.Events, 'TouchShaker1_2'))        
            licktime = SessionData.RawEvents.Trial{tr}.Events.TouchShaker1_2; % -(SessionData.TrialStartTime(tr)*0.001);
            plot( licktime, tr*ones(1, numel(licktime)), '.m', 'MarkerSize', 2);
            hold on;
        end
    end
    ylim([0 SessionData.nTrials]);
    xlim([0 7]);
    set(gca,'color','none', 'TickDir', 'out');     
    set(gca,'TickLength', [0.01 0.025]*1.5);    
    set(gca, 'FontSize', 14, 'FontWeight', 'Normal', 'Box', 'off');
    ylabel('Trials (#)', 'FontSize', 16, 'FontWeight', 'Normal'); 
    xlabel('Licking Time (sec.)', 'FontSize', 16, 'FontWeight', 'Normal'); 
    pt = patch([0.6 0.6 1.6 1.6], [0 SessionData.nTrials SessionData.nTrials 0], 'k');
    pt.FaceColor = [0.7 0.7 0.7];
    pt.FaceAlpha = 0.4;
    pt.EdgeColor = [0.7 0.7 0.7];
    pt.EdgeAlpha = 0.4;
    plot([2 2], [0 SessionData.nTrials], '--k', 'LineWidth', 2);
    text(min(get(gca, 'xlim'))-0.175*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))),...
        'c', 'FontSize', 20, 'FontWeight', 'Bold');
    
    axes('Position', [0.55 0.35 0.25 0.25]);   
    hold off;
    scale = 0:0.05:1;
    br = bar(scale(1:end-1)+0.005, histcounts(WaitForResponse, scale));
    br.FaceColor = 'b';
    br.EdgeColor = 'none';
    axis(gca, 'square');
    set(gca,'color','none', 'TickDir', 'out');     
    set(gca,'TickLength', [0.01 0.025]*1.5);    
    set(gca, 'FontSize', 9, 'FontWeight', 'Normal', 'Box', 'off');
    xlabel('Wait For Response (sec.)', 'FontSize', 18, 'FontWeight', 'Normal');
    ylabel('Trials (#)', 'FontSize', 18, 'FontWeight', 'Normal');
    title(sprintf('n = %d', numel(WaitForResponse)), 'FontSize', 10, 'FontWeight', 'Normal');
    text(min(get(gca, 'xlim'))-0.25*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))),...
        'd', 'FontSize', 20, 'FontWeight', 'Bold');
end