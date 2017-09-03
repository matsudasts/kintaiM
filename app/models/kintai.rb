class Kintai < ApplicationRecord
    validate :check_kintai_input, on: :create
    validate :check_kintai_input_edit, on: :update

    scope :order_by_date, -> { order("kintai_from") }

    scope :search_by_month, ->(param){
        where(kintai_year: param[0..3], kintai_month: param[4..5])
    }

    scope :search_by_date, ->(param){
        where(kintai_date: (param[0..3] + param[5..6] + param[8..9]).to_date)
    }

    attr_accessor :kintai_date_from_disp

    def exists_kintai(yyyymmdd)
        if Kintai.where("strftime('%Y%m%d', kintai_from) = ?", yyyymmdd).exists?
            #errors.add("指定された日の出勤は既に登録されています。","")
            true
        else
            false
        end
    end

    private
    # 新規登録時の入力チェック
    def check_kintai_input
        exists_kintai((kintai_from-32400).strftime('%Y%m%d').to_s)
    end

    # 編集時の入力チェック
    def check_kintai_input_edit
        correct_time(kintai_from.strftime('%H%M'))
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

end
