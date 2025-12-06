library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.music_pkg.ALL;

entity instruction_decoder is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        rom_data    : in  STD_LOGIC_VECTOR(15 downto 0); 
        rom_addr    : out INTEGER range 0 to 31;         
        tone_freq   : out INTEGER;                       
        tone_enable : out STD_LOGIC                      
    );
end instruction_decoder;

architecture Behavioral of instruction_decoder is
    type state_type is (FETCH, DECODE, EXECUTE_PLAY, EXECUTE_WAIT);
    signal current_state, next_state : state_type;
    
    signal program_counter : integer := 0;
    signal wait_timer      : integer := 0;
    
    signal opcode : std_logic_vector(1 downto 0);
    signal operand : integer;
    
begin
    opcode <= rom_data(15 downto 14);
    operand <= to_integer(unsigned(rom_data(13 downto 0)));
    rom_addr <= program_counter;

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= FETCH;
            program_counter <= 0;
            wait_timer <= 0;
        elsif rising_edge(clk) then
            case current_state is
                when FETCH =>
                    current_state <= DECODE;
                    
                when DECODE =>
                    if opcode = OP_PLAY then
                        current_state <= EXECUTE_PLAY;
                    elsif opcode = OP_WAIT then
                        current_state <= EXECUTE_WAIT;
                        wait_timer <= 0;
                    elsif opcode = OP_LOOP then
                        program_counter <= 0;
                        current_state <= FETCH;
                    else 
                        current_state <= FETCH;
                    end if;
                    
                when EXECUTE_PLAY =>
                    program_counter <= program_counter + 1;
                    current_state <= FETCH;

                when EXECUTE_WAIT =>
                    if wait_timer < (operand * 50000) then
                        wait_timer <= wait_timer + 1;
                    else
                        program_counter <= program_counter + 1;
                        current_state <= FETCH;
                    end if;
            end case;
        end if;
    end process;
    
    process(current_state, operand)
    begin
        if current_state = EXECUTE_PLAY then
             tone_freq <= calc_divisor(operand); 
             tone_enable <= '1';
        elsif current_state = EXECUTE_WAIT then
             tone_enable <= '0';
             tone_freq <= 0;
        else
             tone_enable <= '0';
             tone_freq <= 0;
        end if;
    end process;

end Behavioral;
