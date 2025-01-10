library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_Display is
    Port (
        clk       : in  std_logic;
        clear     : in  std_logic;
        mem_dump  : in  std_logic := '0';
        seg       : out std_logic_vector(6 downto 0); -- Seven-segment segments (a-g)
        an        : out std_logic_vector(3 downto 0)  -- Seven-segment anodes
    );
end CPU_Display;

architecture Behavioral of CPU_Display is

    -- Component Declarations
    component CPU
        Port (
            clk        : in  std_logic;
            clear      : in  std_logic;
            mem_dump   : in  std_logic := '0';
            alu_result : out std_logic_vector(15 downto 0) -- Expose ALU result
        );
    end component;

    component SevenSegmentDisplay
        Port (
            clk       : in  std_logic;
            value     : in  std_logic_vector(15 downto 0); -- Input value to display
            seg       : out std_logic_vector(6 downto 0);  -- Seven-segment segments (a-g)
            an        : out std_logic_vector(3 downto 0)   -- Seven-segment anodes
        );
    end component;

    -- Internal Signal for ALU Result
    signal alu_result_internal : std_logic_vector(15 downto 0);

begin

    -- Instantiate the CPU_3380 Processor
    MIPS_CPU: CPU
        port map (
            clk        => clk,
            clear      => clear,
            mem_dump   => mem_dump,
            alu_result => alu_result_internal -- Connect ALU result
        );

    -- Instantiate the Seven-Segment Display Controller
    Display: SevenSegmentDisplay
        port map (
            clk       => clk,
            value     => alu_result_internal, -- Display the ALU result
            seg       => seg,
            an        => an
        );

end Behavioral;
