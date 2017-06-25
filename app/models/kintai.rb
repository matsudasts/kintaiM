class Kintai < ApplicationRecord
    validate :check_kintai_input, on: :create
    validate :check_kintai_input_edit, on: :update

    scope :order_by_date, -> { order("kintai_date") }

    scope :search_by_date, ->(param){
        if param.present? && param =~ /^[0-9]+$/ && param.length < 9
            if param.length == 4
                where(kintai_year: param[0..3])
            elsif param.length == 6
                where(kintai_year: param[0..3], kintai_month: param[4..5])
            elsif param.length == 8
                where(kintai_year: param[0..3], kintai_month: param[4..5], kintai_day: param[6..7])
            end
        end
    }

    private
    # 新規登録時の入力チェック
    def check_kintai_input       
        correct_time(kintai_from)
        exists_kintai()
    end

    # 編集時の入力チェック
    def check_kintai_input_edit
        correct_time(kintai_from)
    end

    # 時間の入力をチェックする
    def correct_time(hhmm)
        if !kintai_from.present?
            errors.add("時間は必須入力です。","")
        elsif kintai_from.length != 4
            errors.add("時間は4桁で入力して下さい。","")
        elsif hhmm !~ /^[0-9]+$/
            errors.add("不正な時間です。","")
        elsif !(hhmm[0..1].to_i).between?(0, 23) || !(hhmm[2..3].to_i).between?(0, 59)
            errors.add("不正な時間です。","")
        end
    end

    def exists_kintai
        if Kintai.exists?(kintai_date: kintai_date)
            errors.add("指定された年月の出勤は既に登録されています。","")
        end
    end

end
