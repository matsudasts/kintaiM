module KintaisHelper

    def format_yyyymmdd()
        Time.now.year.to_s + "/" + format("%02d", Time.now.month.to_s) + "/" +
            format("%02d", Time.now.month.to_s) 
    end

end
