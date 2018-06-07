//Basic dimensions
z_dim = 5; //item height
min_gap = .1; //smallest gap width
max_gap = .4; //largest gap width
step_size = .1; //step size for increasing gaps
buffer = 3; //space to either side of gap

//Generated dimensions
gaps = [for (i = [min_gap:step_size:max_gap]) i];

//Item Length
x_dim = 2*buffer*len(gaps)+ addl(gaps) + buffer;

//Y dimension based on aspect ratio (may not fit text, if x is too small)
y_dim = .66*x_dim;

//Gap depth is half of the overall height
depth = z_dim/2;

//Create Item
difference(){
    //Basic shape
    cube([x_dim, y_dim, z_dim]);
    //Generate gaps+text
    union(){
        for (i = [0:len(gaps)-1]){
            //Each Gap
            move = [(2*i+1)*buffer+min_gap+i*step_size,0,z_dim/2];
            translate(move)
                cube([gaps[i], y_dim, z_dim/2]);
            //Calculate space between gaps
            solid_space = 2*buffer-gaps[i];
            //Generate accompanying text
            translate(move+[solid_space/2+gaps[i],buffer,0])
                rotate([0,0,90])
                    linear_extrude(z_dim/2)
                    text(str(gaps[i]," mm"), .5*solid_space,valign="center");
        }
    }
}

//Function to sum list of numbers
function addl(list, c=0) = 
    c < len(list) - 1 ?
    list[c] + addl(list, c+1)
    :
    list[c];

