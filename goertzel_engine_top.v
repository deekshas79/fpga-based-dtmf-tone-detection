`timescale 1ns / 1ps

module goertzel_engine_top(
   input clk,
   input rst_n,
   input [31:0]signal,
   input sampling_pulse,
   output [3:0] low_grp_freq,
   output [3:0] high_grp_freq
   );

// k = round((i/fs)*N);   omega = (2 * pi * k) / N; m=2*cos(omega)
parameter M1 = 32'h1ED77;  // for 697 Hz
parameter M2 = 32'h1E9F5;  // for 770 Hz
parameter M3 = 32'h1E52B;  // for 852 Hz
parameter M4 = 32'h1DED2;  // for 941 Hz
parameter M5 = 32'h1C951;  // for 1209 Hz
parameter M6 = 32'h1BD7D;  // for 1336 Hz
parameter M7 = 32'h1B090;  // for 1477 Hz
parameter M8 = 32'h19EF3;  // for 1633 Hz

//datatype declaration
wire [31:0] signal_reg;

// First previous values of eight goertzel engines
wire [31:0] Sprev1_M1;
wire [31:0] Sprev1_M2;
wire [31:0] Sprev1_M3;
wire [31:0] Sprev1_M4;
wire [31:0] Sprev1_M5;
wire [31:0] Sprev1_M6;
wire [31:0] Sprev1_M7;
wire [31:0] Sprev1_M8;

// Second previous values of eight goertzel engines
wire [31:0] Sprev2_M1;
wire [31:0] Sprev2_M2;
wire [31:0] Sprev2_M3;
wire [31:0] Sprev2_M4;
wire [31:0] Sprev2_M5;
wire [31:0] Sprev2_M6;
wire [31:0] Sprev2_M7;
wire [31:0] Sprev2_M8;

// Outputs of GE
wire [31:0] s_ge_M1;
wire [31:0] s_ge_M2;
wire [31:0] s_ge_M3;
wire [31:0] s_ge_M4;
wire [31:0] s_ge_M5;
wire [31:0] s_ge_M6;
wire [31:0] s_ge_M7;
wire [31:0] s_ge_M8;

// output of counter
wire mag_en;

// outputs of magnitude module
   wire [31:0] mag_M1;
   wire [31:0] mag_M2;
   wire [31:0] mag_M3;
   wire [31:0] mag_M4;
   wire [31:0] mag_M5;
   wire [31:0] mag_M6;
   wire [31:0] mag_M7;
   wire [31:0] mag_M8;

// registering the input x(n)
takeinput u_signal_reg(
  .x      (signal),
  .s      (signal_reg),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );
  
  // Instantiation of magnitude enable generator
  counter u_meg(
  .clk               (clk),
  .rst_n             (rst_n),
  .sampling_pulse    (sampling_pulse),
  .cnt               (),
  .tres_pulse        (mag_en)
  );
  
  // instantiation of 1st Goertzel's engine
goertzel_engine #(
  .M      (M1)
)u_M1_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M1), // first previous value of GE
  .Sprev2 (Sprev2_M1), // second previous value of GE
  .sn     (s_ge_M1) // Output of goertzel engine
    );

    // registering Sprev1_M1 Goertzel engine
takeinput u_Sprev1_M1(
  .x      (s_ge_M1),
  .s      (Sprev1_M1),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M1 Goertzel engine
takeinput u_Sprev2_M1(
  .x      (Sprev1_M1),
  .s      (Sprev2_M1),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

// instantiation of magnitude block for 1st Goertzel engine  
magnitude #(
   .M                 (M1)
)u_magnitude_M1(
   .Sprev1            (Sprev1_M1),
   .Sprev2            (Sprev2_M1),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M1)
    );


// instantiation of 2nd Goertzel's engine
goertzel_engine #(
  .M      (M2)
)u_M2_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M2), // first previous value of GE
  .Sprev2 (Sprev2_M2), // second previous value of GE
  .sn     (s_ge_M2) // 
    );

    // registering Sprev1_M2 Goertzel engine
takeinput u_Sprev1_M2(
  .x      (s_ge_M2),
  .s      (Sprev1_M2),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M2 Goertzel engine
takeinput u_Sprev2_M2(
  .x      (Sprev1_M2),
  .s      (Sprev2_M2),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

  // instantiation of magnitude block for 2nd Goertzel engine  
magnitude #(
   .M                 (M2)
)u_magnitude_M2(
   .Sprev1            (Sprev1_M2),
   .Sprev2            (Sprev2_M2),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M2)
    );

    
    // instantiation of 3rd Goertzel's engine
goertzel_engine #(
  .M      (M3)
)u_M3_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M3), // first previous value of GE
  .Sprev2 (Sprev2_M3), // second previous value of GE
  .sn     (s_ge_M3) // 
    );

    // registering Sprev1_M3 Goertzel engine
takeinput u_Sprev1_M3(
  .x      (s_ge_M3),
  .s      (Sprev1_M3),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M3 Goertzel engine
takeinput u_Sprev2_M3(
  .x      (Sprev1_M3),
  .s      (Sprev2_M3),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

// instantiation of magnitude block for 3rd Goertzel engine  
magnitude #(
   .M                 (M3)
)u_magnitude_M3(
   .Sprev1            (Sprev1_M3),
   .Sprev2            (Sprev2_M3),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M3)
    );

    
    // instantiation of 4th Goertzel's engine
goertzel_engine #(
  .M      (M4)
)u_M4_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M4), // first previous value of GE
  .Sprev2 (Sprev2_M4), // second previous value of GE
  .sn     (s_ge_M4) // 
    );

    // registering Sprev1_M4 Goertzel engine
takeinput u_Sprev1_M4(
  .x      (s_ge_M4),
  .s      (Sprev1_M4),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M4 Goertzel engine
takeinput u_Sprev2_M4(
  .x      (Sprev1_M4),
  .s      (Sprev2_M4),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

// instantiation of magnitude block for 4th Goertzel engine  
magnitude #(
   .M                 (M4)
)u_magnitude_M4(
   .Sprev1            (Sprev1_M4),
   .Sprev2            (Sprev2_M4),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M4)
    );


    // instantiation of 5th Goertzel's engine
goertzel_engine #(
  .M      (M5)
)u_M5_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M5), // first previous value of GE
  .Sprev2 (Sprev2_M5), // second previous value of GE
  .sn     (s_ge_M5) // 
    );

    // registering Sprev1_M5 Goertzel engine
takeinput u_Sprev1_M5(
  .x      (s_ge_M5),
  .s      (Sprev1_M5),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M5 Goertzel engine
takeinput u_Sprev2_M5(
  .x      (Sprev1_M5),
  .s      (Sprev2_M5),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

// instantiation of magnitude block for 5th Goertzel engine  
magnitude #(
   .M                 (M5)
)u_magnitude_M5(
   .Sprev1            (Sprev1_M5),
   .Sprev2            (Sprev2_M5),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M5)
    );


    // instantiation of 6th Goertzel's engine
goertzel_engine #(
  .M      (M6)
)u_M6_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M6), // first previous value of GE
  .Sprev2 (Sprev2_M6), // second previous value of GE
  .sn     (s_ge_M6) // 
    );

    // registering Sprev1_M6 Goertzel engine
takeinput u_Sprev1_M6(
  .x      (s_ge_M6),
  .s      (Sprev1_M6),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M6 Goertzel engine
takeinput u_Sprev2_M6(
  .x      (Sprev1_M6),
  .s      (Sprev2_M6),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

// instantiation of magnitude block for 6th Goertzel engine  
magnitude #(
   .M                 (M6)
)u_magnitude_M6(
   .Sprev1            (Sprev1_M6),
   .Sprev2            (Sprev2_M6),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M6)
    );
    
    
   // instantiation of 7th Goertzel's engine
goertzel_engine #(
  .M      (M7)
)u_M7_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M7), // first previous value of GE
  .Sprev2 (Sprev2_M7), // second previous value of GE
  .sn     (s_ge_M7) // 
    );

   // registering Sprev1_M7 Goertzel engine
takeinput u_Sprev1_M7(
  .x      (s_ge_M7),
  .s      (Sprev1_M7),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M7 Goertzel engine
takeinput u_Sprev2_M7(
  .x      (Sprev1_M7),
  .s      (Sprev2_M7),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

// instantiation of magnitude block for 7th Goertzel engine  
magnitude #(
   .M                 (M7)
)u_magnitude_M7(
   .Sprev1            (Sprev1_M7),
   .Sprev2            (Sprev2_M7),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M7)
    );
    

   // instantiation of 8th Goertzel's engine
goertzel_engine #(
  .M      (M8)
)u_M8_goertzel_engine(
  .clk    (clk),  // clock
  .rst_n  (rst_n), //active low reset
  .xn     (signal_reg), // sampled tone 
  .Sprev1 (Sprev1_M8), // first previous value of GE
  .Sprev2 (Sprev2_M8), // second previous value of GE
  .sn     (s_ge_M8) // 
    );

    // registering Sprev1_M8 Goertzel engine
takeinput u_Sprev1_M8(
  .x      (s_ge_M8),
  .s      (Sprev1_M8),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

 // registering Sprev2_M8 Goertzel engine
takeinput u_Sprev2_M8(
  .x      (Sprev1_M8),
  .s      (Sprev2_M8),
  .en     (sampling_pulse),
  .clk    (clk),
  .rst_n  (rst_n)
  );

  // instantiation of magnitude block for 8th Goertzel engine  
magnitude #(
   .M                 (M8)
)u_magnitude_M8(
   .Sprev1            (Sprev1_M8),
   .Sprev2            (Sprev2_M8),
   .clk               (clk),
   .rst_n             (rst_n),
   .activation_pulse  (mag_en),
   .mag               (mag_M8)
    );
    
    
 // instantiation of comparator block for key detection
 comparator u_comparator_low_grp_frequency(
    .a                (mag_M1),
    .b                (mag_M2),
    .c                (mag_M3),
    .d                (mag_M4),
    .pattern          (low_grp_freq)
    );
    
   
 comparator u_comparator_high_grp_frequency( 
    .a                (mag_M5),               
    .b                (mag_M6),               
    .c                (mag_M7),               
    .d                (mag_M8),               
    .pattern          (high_grp_freq)          
    );                                      

endmodule
