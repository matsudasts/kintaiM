class Kintai < ApplicationRecord
    validate :check_kintai_input, on: :create
    validate :check_kintai_input_edit, on: :update

    attr_accessor :time_from

    scope :order_by_date, -> { order("kintai_from") }

    scope :search_by_date, ->(param){
        if param.present? && param =~ /^[0-9]+$/
            where(kintai_year: param[0..3], kintai_month: param[4..5])
        end
    }

    private
    # 新規登録時の入力チェック
    def check_kintai_input     
        correct_time(time_from)
        exists_kintai((kintai_from - 32400).strftime('%Y%m%d'))
    end

    # 編集時の入力チェック
    def check_kintai_input_edit
        correct_time(time_from)
    end

    # 時間の入力をチェックする
    def correct_time(hhmm)
        if !hhmm.present?
            errors.add("時間を4桁で入力して下さい。","")
        elsif hhmm !~ /^[0-9]+$/
            errors.add("不正な時間です。","")
        elsif !(hhmm[0..1].to_i).between?(0, 23) || !(hhmm[2..3].to_i).between?(0, 59)
            errors.add("不正な時間です。","")
        end
    end

    def exists_kintai(yyyymmdd)
        if Kintai.where("strftime('%Y%m%d', kintai_from) = ?", yyyymmdd).exists?
            errors.add("指定された年月の出勤は既に登録されています。","")
        end
    end

end
