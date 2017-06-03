class KintaisController < ApplicationController
    require 'date'

    def new
        @kintai = Kintai.new
    end

    def create
        @kintai = Kintai.new(kintai_params)

        if @kintai.save
            flash[:msg] = "出勤時間を登録しました。"
            redirect_to new_kintai_path
        else
            return render "new"
        end
    end

    def kintai_params
        params.require(:kintai).permit(
            :kintai_date,
            :kintai_from
        )
    end
end
