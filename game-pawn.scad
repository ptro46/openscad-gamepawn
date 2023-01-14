$fn=100;

base_x = 20 ;
base_y = 20 ;
base_z = 5 ;

function tetrahedron_h(size) = size*sqrt(2/3) ;

module round_tetrahedron(size,r,h) {
    tetrahedron_points = [
            [0,0,0],
            [size,0,0],
            [size/2,size*sqrt(3)/2,0],
            [size/2,size*sqrt(3)/6,size*sqrt(2/3)]] ;
    
    translate([-size/2,-size*sqrt(3)/6,-h/2]) {
        hull() {
            translate([tetrahedron_points[0][0],
                       tetrahedron_points[0][1],
                       tetrahedron_points[0][2]]) {
                color("red")
                sphere(r);
            }
            translate([tetrahedron_points[1][0],
                       tetrahedron_points[1][1],
                       tetrahedron_points[1][2]]) {
                color("blue")
                sphere(r);
            }
            translate([tetrahedron_points[2][0],
                       tetrahedron_points[2][1],
                       tetrahedron_points[2][2]]) {
                color("green")
                sphere(r);
            }
            translate([tetrahedron_points[3][0],
                       tetrahedron_points[3][1],
                       tetrahedron_points[3][2]]) {
                color("yellow")
                sphere(r);
            }
        }
    }
}

module round_cube(x,y,z,r) {
    cyl_r = r ;
    t_x = x/2-cyl_r ;
    t_y = y/2-cyl_r ;        
    hull() {
        translate([t_x,t_y,0]) {
            cylinder(h=z,r=cyl_r,center=true);
        }
        translate([-t_x,t_y,0]) {
            cylinder(h=z,r=cyl_r,center=true);
        }
        translate([t_x,-t_y,0]) {
            cylinder(h=z,r=cyl_r,center=true);
        }
        translate([-t_x,-t_y,0]) {
            cylinder(h=z,r=cyl_r,center=true);
        }
    }
}

module base() {
    round_cube(base_x,base_y,base_z,3);
    tube_z = base_z * 2 ;
    translate([0,0,tube_z/2+base_z/2]) {
        cylinder(h=tube_z,r=base_x/6,center=true);
    }
}

module pawn_tetrahedron() {
    tetrahedron_size=20 ;
    tetrahedron_round = 2 ;

    union() {
        base();
        translate([0,0,base_z*2-3]) {
            translate([0,0,tetrahedron_h(tetrahedron_size)/2+tetrahedron_round]) {
                round_tetrahedron(tetrahedron_size,tetrahedron_round,tetrahedron_h(tetrahedron_size));
            }
        }
    }
}

module pawn_tetrahedron_inv() {
    tetrahedron_size=20 ;
    tetrahedron_round = 2 ;

    union() {
        base();
        translate([0,0,base_z*2]) {
            translate([0,0,tetrahedron_h(tetrahedron_size)/2-5]) {
                rotate([0,180,0]) {
                    round_tetrahedron(tetrahedron_size,tetrahedron_round,tetrahedron_h(tetrahedron_size));
                }
            }
        }
    }
}

module pawn_cube() {
    union() {
        base();
        translate([0,0,base_z*3]) {
            round_cube(15,15,10,3);
        }
    }
}

module pawn_cube_inv() {
    union() {
        base();
        translate([0,0,base_z*3]) {
            rotate([90,0,0]) {
                round_cube(15,15,10,3);
            }
        }
    }
}

module pawn_sphere() {
    union() {
        base();
        translate([0,0,base_z*3]) {
            sphere(d=15);
        }
    }
}

module pawn_cylindre() {
    union() {
        base();
        translate([0,0,base_z*3]) {
            cylinder(h=10,d=15,center=true);
        }
    }
}

module pawn_cylindre_inv() {
    union() {
        base();
        translate([0,0,base_z*3]) {
            rotate([90,0,0]) {
                cylinder(h=10,d=15,center=true);
            }
        }
    }
}

shift = base_x + base_x/2;

base();

translate([-shift,0,0]) {
    pawn_cube();
}

translate([shift,0,0]) {
    pawn_tetrahedron();
}

translate([0,-shift,0]) {
    pawn_sphere();
}

translate([0,+shift,0]) {
    pawn_cylindre();
}

translate([+shift,+shift,0]) {
    pawn_tetrahedron_inv();
}

translate([-shift,-shift,0]) {
    pawn_cylindre_inv();
}

translate([-shift,shift,0]) {
    pawn_cube_inv();
}
