class KintaisController < ApplicationController

    def new
        @kintai = Kintai.new
    end

    def create
        @kintai = Kintai.new(kintai_params)
        @kintai.kintai_year = params[:kintai]["kintai_from(1i)"]
        @kintai.kintai_month = format("%02d", params[:kintai]["kintai_from(2i)"])
        @kintai.kintai_day = format("%02d", params[:kintai]["kintai_from(3i)"])
        # 時間がずれるので、9時間引いて登録
        @kintai.kintai_from = get_kintai_date

        if @kintai.save
            flash[:msg] = "出勤時間を登録しました。"
            redirect_to new_kintai_path
        else
            return render :new
        end
    end

    def edit
        @kintai = Kintai.find(params[:id])
    end

    def update
        @kintai = Kintai.find(params[:id])
        @kintai.assign_attributes(kintai_params)

        if @kintai.save
            flash[:msg] = "出勤時間を編集しました。"
            redirect_to '/kintais/kintai_lists/' + @kintai.kintai_year.to_s + @kintai.kintai_month.to_s
        else
            render :edit
        end
    end

    def kintai_lists
        @kintai = Kintai.search_by_date(params[:kintai_date]).order_by_date
        render :index
    end

    def kintai_params
        params.require(:kintai).permit(
            :kintai_from,
            :kintai_year,
            :kintai_month,
            :kintai_day            
        )
    end

    private
    def get_kintai_date
        (params[:kintai]["kintai_from(1i)"] + params[:kintai]["kintai_from(2i)"] + params[:kintai]["kintai_from(3i)"] + params[:kintai]["kintai_from(4i)"] + params[:kintai]["kintai_from(5i)"]).to_datetime - 0.375
    end
end
