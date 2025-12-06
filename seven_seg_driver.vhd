library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_seg_driver is
    Port (
        clk          : in STD_LOGIC;
        current_addr : in INTEGER;
        active_ch    : in STD_LOGIC_VECTOR(3 downto 0);
        hex0_out     : out STD_LOGIC_VECTOR(7 downto 0);
        hex1_out     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end seven_seg_driver;

architecture Behavioral of seven_seg_driver is
    function to_seven_seg(val : integer) return std_logic_vector is
    begin
        case val is
            when 0 => return "11000000"; -- 0
            when 1 => return "11111001"; -- 1
            when 2 => return "10100100"; -- 2
            when 3 => return "10110000"; -- 3
            when 4 => return "10011001"; -- 4
            when 5 => return "10010010"; -- 5
            when 6 => return "10000010"; -- 6
            when 7 => return "11111000"; -- 7
            when 8 => return "10000000"; -- 8
            when 9 => return "10010000"; -- 9
            when 10 => return "10001000"; -- A
            when 11 => return "10000011"; -- b
            when 12 => return "11000110"; -- C
            when 13 => return "10100001"; -- d
            when 14 => return "10000110"; -- E
            when 15 => return "10001110"; -- F
            when others => return "11111111"; -- Off
        end case;
    end function;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Display lower nibble of address on HEX0
            hex0_out <= to_seven_seg(current_addr mod 16);
            -- Display upper nibble of address on HEX1
            hex1_out <= to_seven_seg((current_addr / 16) mod 16);
        end if;
    end process;
end Behavioral;
