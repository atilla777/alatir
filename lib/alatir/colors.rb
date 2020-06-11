module Alatir
  module Colors
    COLORS = {
      black: "\e[30m",
      red: "\e[31m",
      green: "\e[32m",
      blue: "\e[34m",
      brown: "\e[33m",
      magneta: "\e[35m",
      cyan: "\e[36m",
    }
    module_function

    def color_puts(string, color = false)
      color = COLORS.fetch(color, false)
      if color
        puts "#{color}#{string}\e[0m"
      else
        puts string
      end
    end

    #red(string); puts "\e[31m#{string}\e[0m" end
    #green;          "\e[32m#{string}\e[0m" end
    #brown;          "\e[33m#{string}\e[0m" end
    #blue;           "\e[34m#{string}\e[0m" end
    #magenta;        "\e[35m#{string}\e[0m" end
    #cyan;           "\e[36m#{string}\e[0m" end
    #gray;           "\e[37m#{string}\e[0m" end
    #def ##"\e[4#s{t}r\ingngirtse[0m" end
    #bg_red;         "\e[41m#{string}\e[0m" end
    #bg_green;       "\e[42m#{string}\e[0m" end
    #bg_brown;       "\e[43m#{string}\e[0m" end
    #bg_blue;        "\e[44m#{string}\e[0m" end
    #bg_magenta;     "\e[45m#{string}\e[0m" end
    #bg_cyan;        "\e[46m#{string}\e[0m" end
    #bg_gray;        "\e[47m#{string}\e[0m" end
    #def ##"\e[1m#{self}\e[22m" end
    #italic;         "\e[3m#{self}\e[23m" end
    #underline;      "\e[4m#{self}\e[24m" end
    #blink;          "\e[5m#{self}\e[25m" end
    #reverse_color;  "\e[7m#{self}\e[27m" end
  end
end
