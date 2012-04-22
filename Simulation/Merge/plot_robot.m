function plot_robot(Robot, style)
% PLOT_ROBOT Plot function for the robots.
%
%   PLOT_ROBOT(ROBOT,STYLE) plots the robots on the field with properties
%   defined in the flag STYLE. The string STYLE may contain:
%
%   Shapes
%   0  Draws circles in true size (given in global RobotParam.radius)
%   @  Same as above, but filled. Changes the color for all the following 
%      stuff to black (otherwise, one couldn't see it)
%   -  Includes the direction indicator (given in Robot.dir)
%   +  Draws crosses
%   #  Enumerate Robots
%
%   Colors
%   t  team-specific
%
%   from colorcode.m:
%   r  red
%   b  blue
%   g  green
%   y  yellow
%   m  magenta
%   k  black
%
%   Example usage: plot_robots(Robot_measured, "ob-")

    global RobotParam;
  
    
%----------- Set default color  -----------%
    
    colorcode;  
    color = [0 0 0]; % default color: black  

    
%----------- Reading flag  -----------%
    
    fn = fieldnames(c);
    for l = style
        hit = strfind(c.letters, l);
        if (hit)
            color = c.(fn{hit});
        end
    end

    
%----------- Check for team-specific colors  -----------%
    
    bunt = false;
    if (strfind(style, 't'))
        bunt = true;
    end
 
    
%----------- Check for filled circles  -----------%
    
    if (strfind(style, '@'))
        for i=1:8
            if (bunt)
                color = Robot(i).color;
            end
            draw_circle(Robot(i).x, Robot(i).y, RobotParam.radius, color, 1);
        end        
        color = [0 0 0]; % for all the following eye-candy
        bunt = false;
    end

    
%----------- Check for bordered circles  -----------%
    
    if (strfind(style, '0'))
        for i=1:8
            if (bunt)
                color = Robot(i).color;
            end
            draw_circle(Robot(i).x, Robot(i).y, RobotParam.radius, color, 0);
        end
    end

    
%----------- Check for numbered players  -----------%
    
    if (strfind(style, '#'))
        for i=1:8
            if (bunt)
                color = Robot(i).color;
            end
            text(Robot(i).x, Robot(i).y,num2str(mod(i,4)+1), 'Color', color);
        end
    end

    
%----------- Check for crosses  -----------%    
    
    if (strfind(style, '+'))
        for i=1:8
            if (bunt)
                color = Robot(i).color;
            end
            plot(Robot(i).x, Robot(i).y,'+', 'Color', color);
        end
    end

    
%----------- Check for direction indication  -----------%    
    
    if (strfind(style, '-'))
        for i=1:8
            if (bunt)
                color = Robot(i).color;
            end

            if ( ~isnan(Robot(i).dir) )
                xdir = Robot(i).x + RobotParam.radius * cos(Robot(i).dir);
                ydir = Robot(i).y + RobotParam.radius * sin(Robot(i).dir);
                line([Robot(i).x xdir],[Robot(i).y ydir],'Color',color);
            end
        end
    end   
end