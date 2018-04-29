%% the script to obtain the CASIA pictures from .avi files.
% the save path:
%     @CASIA/train/real: './database/CASIA/train/real/xxxxx.png'
%     @CASIA/train/fake: './database/CASIA/train/fake/xxxxx.png'
%     @CASIA/test/real: './database/CASIA/test/real/xxxxx.png'
%     @CASIA/test/fake: './database/CASIA/test/fake/xxxxx.png'

clear all, close all, clc
%% training set
detector = vision.CascadeObjectDetector('MinSize', [100,100]);
count_real = 0;
count_fake = 0;
for IdxSubject = 1 : 20
    for IdxData = 1 : 8
        if IdxData <= 8
            Name = ['./database/CASIA/train_release/' num2str(IdxSubject) '/' num2str(IdxData) '.avi'];
        else
            Name = ['./database/CASIA/train_release/' num2str(IdxSubject) '/HR_' num2str(IdxData-8) '.avi'];
        end
        Mov = VideoReader(Name);
        for IdxFrame = 1 : Mov.NumberOfFrames
            data = read(Mov, IdxFrame);
            box = step(detector, data);
            if size(box, 1) == 1
                frame_now = data(box(2):box(2)+box(4), box(1):box(1)+box(3), :);
                if IdxData <= 2
                    imwrite(frame_now, ['.\database\CASIA\train\real\' num2str(count_real, '%05d') '.png']);
                    count_real = count_real + 1;
                else
                    imwrite(frame_now, ['.\database\CASIA\train\fake\' num2str(count_fake, '%05d') '.png']);
                    count_fake = count_fake + 1;
                end
            end
        end
        disp([num2str(IdxSubject) ', ' num2str(IdxData)])
        clear Mov;
    end
end

clear all, close all, clc
%% test set
detector = vision.CascadeObjectDetector('MinSize', [100,100]);
count_real = 0;
count_fake = 0;
for IdxSubject = 1 : 30
    for IdxData = 1 : 8
        if IdxData <= 8
            Name = ['./database/CASIA/train_release/' num2str(IdxSubject) '/' num2str(IdxData) '.avi'];
        else
            Name = ['./database/CASIA/train_release/' num2str(IdxSubject) '/HR_' num2str(IdxData-8) '.avi'];
        end
        Mov = VideoReader(Name);
        for IdxFrame = 1 : Mov.NumberOfFrames
            data = read(Mov, IdxFrame);
            box = step(detector, data);
            if size(box, 1) == 1
                frame_now = data(box(2):box(2)+box(4), box(1):box(1)+box(3), :);
                if IdxData <= 2
                    imwrite(frame_now, ['.\database\CASIA\test\real\' num2str(count_real, '%05d') '.png']);
                    count_real = count_real + 1;
                else
                    imwrite(frame_now, ['.\database\CASIA\test\fake\' num2str(count_fake, '%05d') '.png']);
                    count_fake = count_fake + 1;
                end
            end
        end
        disp([num2str(IdxSubject) ', ' num2str(IdxData)])
        clear Mov;
    end
end