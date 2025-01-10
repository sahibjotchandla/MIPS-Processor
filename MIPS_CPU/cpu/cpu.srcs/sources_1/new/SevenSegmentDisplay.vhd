library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegmentDisplay is
    Port (
        clk   : in  std_logic;
        value : in  std_logic_vector(15 downto 0); -- 16-bit input value
        seg   : out std_logic_vector(6 downto 0);  -- Seven-segment segments (a-g)
        an    : out std_logic_vector(3 downto 0)   -- Seven-segment anodes
    );
end SevenSegmentDisplay;

architecture Behavioral of SevenSegmentDisplay is

    signal refresh_counter : std_logic_vector(19 downto 0) := (others => '0');
    signal active_digit    : std_logic_vector(1 downto 0) := "00";
    signal hex_digit       : std_logic_vector(3 downto 0);
    signal digit_value     : std_logic_vector(3 downto 0);

begin

    -- Refresh Counter for 7-Segment Display Multiplexing
    process(clk)
    begin
        if rising_edge(clk) then
            refresh_counter <= refresh_counter + 1;
            if refresh_counter(19 downto 18) = "00" then
                active_digit <= active_digit + 1;
            end if;
        end if;
    end process;

    -- Select Active Digit and Value
    process(active_digit, value)
    begin
        case active_digit is
            when "00" =>
                hex_digit <= value(3 downto 0); -- Least significant nibble
                an <= "1110";
            when "01" =>
                hex_digit <= value(7 downto 4);
                an <= "1101";
            when "10" =>
                hex_digit <= value(11 downto 8);
                an <= "1011";
            when "11" =>
                hex_digit <= value(15 downto 12); -- Most significant nibble
                an <= "0111";
            when others =>
                hex_digit <= "0000";
                an <= "1111";
        end case;
    end process;

    -- Hexadecimal to 7-Segment Decoder
    process(hex_digit)
    begin
        case hex_digit is
            when "0000" => seg <= "0000001"; -- 0
            when "0001" => seg <= "1001111"; -- 1
            when "0010" => seg <= "0010010"; -- 2
            when "0011" => seg <= "0000110"; -- 3
            when "0100" => seg <= "1001100"; -- 4
            when "0101" => seg <= "0100100"; -- 5
            when "0110" => seg <= "0100000"; -- 6
            when "0111" => seg <= "0001111"; -- 7
            when "1000" => seg <= "0000000"; -- 8
            when "1001" => seg <= "0000100"; -- 9
            when "1010" => seg <= "0001000"; -- A
            when "1011" => seg <= "1100000"; -- B
            when "1100" => seg <= "0110001"; -- C
            when "1101" => seg <= "1000010"; -- D
            when "1110" => seg <= "0110000"; -- E
            when "1111" => seg <= "0111000"; -- F
            when others => seg <= "1111111"; -- Blank
        end case;
    end process;

end Behavioral;
