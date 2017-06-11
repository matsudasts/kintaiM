class Kintai < ApplicationRecord
    validate :check_kintai_time
    scope :order_by_date, -> { order("kintai_date") }

    private
    def check_kintai_time       
        if !kintai_from.present?
            errors.add("時間は必須入力です。","")
        elsif kintai_from.length != 4
            errors.add("時間は4桁で入力して下さい。","")
        elsif !correct_time(kintai_from)
            errors.add("不正な時間です。","")
        elsif Kintai.exists?(kintai_date: kintai_date)
            errors.add("指定された年月の出勤は既に登録されています。","")
        end
    end

    def correct_time(hhmm)
        if hhmm !~ /^[0-9]+$/
            return false
        end

        if !(hhmm[0..1].to_i).between?(0, 23) || !(hhmm[2..3].to_i).between?(0, 59)
            return false
        end

        true
    end

end
