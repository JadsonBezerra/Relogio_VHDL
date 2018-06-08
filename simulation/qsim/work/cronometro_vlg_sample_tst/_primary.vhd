library verilog;
use verilog.vl_types.all;
entity cronometro_vlg_sample_tst is
    port(
        clock1          : in     vl_logic;
        enable1         : in     vl_logic;
        zerar1          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end cronometro_vlg_sample_tst;
