class KintaisController < ApplicationController

    def new
        @kintai = Kintai.new
    end

    def create
        @kintai = Kintai.new(kintai_params)
        @kintai.kintai_year = params[:kintai]["kintai_date(1i)"]
        @kintai.kintai_month = format("%02d", params[:kintai]["kintai_date(2i)"])
        @kintai.kintai_day = format("%02d", params[:kintai]["kintai_date(3i)"])

        if @kintai.save
            flash[:msg] = "出勤時間を登録しました。"
            redirect_to new_kintai_path
        else
            return render "new"
        end
    end

    def show
        params_year = ""
        params_month = ""
        params_day = ""
      
        # 不正なパラメータの場合は何も表示しない
        if  params[:kintai_date] !~ /^[0-9]+$/
            return false
        end
        if params[:kintai_date].length > 8
            return false
        end

        # パラメータから勤怠を検索
        if params[:kintai_date].length >= 4
            params_year = params[:kintai_date][0..3]
            @kintai = Kintai.where(kintai_year: params_year).order_by_date
        end
        if params[:kintai_date].length >= 6
            params_month = params[:kintai_date][4..5]
            @kintai = Kintai.where(kintai_year: params_year, kintai_month: params_month).order_by_date
        end
        if params[:kintai_date].length >= 8
            params_day = params[:kintai_date][6..7]
            @kintai = Kintai.where(kintai_year: params_year, kintai_month: params_month, kintai_day: params_day)
        end

    end

    def kintai_params
        params.require(:kintai).permit(
            :kintai_date,
            :kintai_from
        )
    end
end
