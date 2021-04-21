function reg_param = mp2rage_selectregparam(MP2RAGE, mask)

% Make regtests output directory.
if ~exist('regtests_output'); mkdir regtests_output; end

%% Calculate denoised mp2rage signal intensity for a range of likely regularization parameters.

regtest = [1 2 4 6 12 16 18 24 48 64 96];

for r = 1:length(regtest)
    
    disp(['Evaluating regularization parameter of ' num2str(regtest(r)) '...']);
    
    %% Denoise based on this regtest.
    [MP2RAGEimgRobustPhaseSensitive]=RobustCombination(MP2RAGE, regtest(r));
    
    % Save figure for qa.
    saveas(gcf, fullfile('regtests_output', ['qa_reg', num2str(regtest(r)) '.png']));
    
    % Close figure.
    close all;
    
    % Convert MP2RAGEimg.img class from int16 to double for compatability with mask.data.
    MP2RAGEimg = double(MP2RAGEimgRobustPhaseSensitive);
    
    %% Make mp2rage intensity maps --for only brain tissue-- for this regtest (i.e., r).
    mp2rage_intensity(:, r) = MP2RAGEimg(:).*double(mask(:));
    %     mp2rage_intensity(:, r) = MP2RAGEimg(:);
    
    % Convert zeros to NaN.
    mp2rage_intensity(find(mp2rage_intensity==0)) = NaN;
    
    if regtest(r) == 1
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg1 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 2
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg2 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 4
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg4 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 6
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg6 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 12
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg12 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 16
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg16 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 18
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg18 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 24
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg24 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 48
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg48 = temp(~isnan(temp)); clear temp;
        
        
    elseif regtest(r) == 64
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg64 = temp(~isnan(temp)); clear temp;
        
    elseif regtest(r) == 96
        
        % Remove NaN.
        temp = mp2rage_intensity(:, r);
        mp2rage_intensity_reg96 = temp(~isnan(temp)); clear temp;
        
    end
    
end %for 1:length(regtest)

%% Plot summary figure, i.e., all regtests together.
figure

hold on;
facecolor1 = [0.9290 0.6940 0.1250]; %yellow
facecolor12 = [0.4660 0.6740 0.1880]; %green
facecolor24 = [0.4940 0.1840 0.5560]; %purple
facecolor96 = [0.6350 0.0780 0.1840]; %red

linecolor1 = facecolor1;
linecolor12 = facecolor12;
linecolor24 = facecolor24;
linecolor96 = facecolor96;

linecolor2 = [1 1 0];
linecolor4 = [0.8500 0.3250 0.0980];
linecolor6 = [0.9500 0.8250 0.0980];
linecolor16 = [0.3010 0.7450 0.9330];
linecolor18 = [0 0.4470 0.7410]; %blue
linecolor48 = [0.4940 0.1840 0.5560]; % purple
linecolor64 = [0 0 0]; %black

facealpha = 0.4;
edgecolor = 'none';
linewidth = 2;

% subplot(1, 3, 1)
clear toplot;
toplot = double(mp2rage_intensity_reg1(:));
[N_reg1, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg1, 'Color', linecolor1, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg2(:));
[N_reg2, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg2, 'Color', linecolor2, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg4(:));
[N_reg4, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg4, 'Color', linecolor4, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg6(:));
[N_reg6, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg6, 'Color', linecolor6, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg12(:));
[N_reg12, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg12, 'Color', linecolor12, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg16(:));
[N_reg16, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg16, 'Color', linecolor16, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg18(:));
[N_reg18, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg18, 'Color', linecolor18, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg24(:));
[N_reg24, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg24, 'Color', linecolor24, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg48(:));
[N_reg48, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg48, 'Color', linecolor48, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg64(:));
[N_reg64, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg64, 'Color', linecolor64, 'LineWidth', linewidth);

clear toplot;
toplot = double(mp2rage_intensity_reg96(:));
[N_reg96, edges] = histcounts(toplot, 'Normalization', 'probability');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N_reg96, 'Color', linecolor96, 'LineWidth', linewidth);
 
ylim([0 8e-3])
 
pbaspect([1 1 1]);
ylabel('Frequency');
xlabel('Signal Intensity');
hold off;

legend({'reg1', 'reg2', 'reg4', 'reg6', 'reg12', 'reg16', 'reg18', 'reg24', 'reg48', 'reg64', 'reg96'}, 'Location', 'eastoutside');

% Save figure.
saveas(gcf, fullfile('regtests_output', 'MP2RAGE_regularizationtest_allreg.png'));

% Close figure.
close all

% Get minimum rmse betweek reg params.
idx = 1:min([length(N_reg1), length(N_reg2), length(N_reg4), length(N_reg6), length(N_reg12), length(N_reg16), ...
    length(N_reg18), length(N_reg24), length(N_reg48), length(N_reg64), length(N_reg96)]);
rmse(1) = sqrt(mean((N_reg1(idx)-N_reg2(idx)).^2));
rmse(2) = sqrt(mean((N_reg2(idx)-N_reg4(idx)).^2));
rmse(3) = sqrt(mean((N_reg4(idx)-N_reg6(idx)).^2));
rmse(4) = sqrt(mean((N_reg6(idx)-N_reg12(idx)).^2));
rmse(5) = sqrt(mean((N_reg12(idx)-N_reg16(idx)).^2));
rmse(6) = sqrt(mean((N_reg16(idx)-N_reg18(idx)).^2));
rmse(7) = sqrt(mean((N_reg18(idx)-N_reg24(idx)).^2));
rmse(8) = sqrt(mean((N_reg24(idx)-N_reg48(idx)).^2));
rmse(9) = sqrt(mean((N_reg48(idx)-N_reg64(idx)).^2));
rmse(10) = sqrt(mean((N_reg64(idx)-N_reg96(idx)).^2));

p = find(rmse == min(rmse));

% Select the first of the two reg params that gave the lowest rmse.
reg_param_best(1) = regtest(p);
reg_param_best(2) = regtest(p+1);

disp(['Best regularization parameters are ' num2str(reg_param_best(1)) ' and ' num2str(reg_param_best(2)) '. Selecting ' num2str(reg_param_best(1)) '.'])

reg_param = reg_param_best(1);

