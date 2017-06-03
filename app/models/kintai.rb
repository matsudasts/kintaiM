class Kintai < ApplicationRecord
    validate :check_kintai_from

    private
    def check_kintai_from       
        if !kintai_from.present?
            errors.add("時間は必須入力です。","")
        elsif kintai_from.length != 4
            errors.add("時間は4桁で入力して下さい。","")
        elsif !correct_time(kintai_from)
            errors.add("不正な時間です。","")
        elsif Kintai.exists?(kintai_date: kintai_date)
            errors.add("その日の出勤時間は既に登録されています。","")
        end
    end

    private
    def correct_time(hhmm)
        begin
            hh = hhmm[0..1].to_i
            mm = hhmm[2..3].to_i
            DateTime.new(1900,1,1,hh,mm,0)
        rescue
            return false
        end
        true
    end

end
