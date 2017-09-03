class KintaisController < ApplicationController

    def new
        date_now = Time.now.year.to_s + "/" + format("%02d", Time.now.month.to_s) + "/" + 
            format("%02d", Time.now.day.to_s)

        @kintai = Kintai.new
        @kintai.kintai_date_from_disp = date_now
    end

    def create
        kintai = Kintai.search_by_date(params[:kintai]["kintai_date_from_disp"])
        if kintai.count == 0
            @kintai = Kintai.new(kintai_params)
            @kintai.kintai_date = params[:kintai]["kintai_date_from_disp"].to_date
            @kintai.kintai_year = params[:kintai]["kintai_date_from_disp"][0..3]
            @kintai.kintai_month = params[:kintai]["kintai_date_from_disp"][5..6]
            @kintai.kintai_day = params[:kintai]["kintai_date_from_disp"][8..9]
            # 時間がずれるので、9時間引いて登録
            @kintai.kintai_from = get_kintai_date
        else
            @kintai = Kintai.find(kintai[0].id)
            @kintai.assign_attributes(kintai_params)
        end

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
        @kintai = Kintai.search_by_month(params[:kintai_date_from_disp]).order_by_date
        render :index
    end

    def kintai_params
        params.require(:kintai).permit(
            :kintai_from,
            :kintai_year,
            :kintai_month,
            :kintai_day,
            :kintai_date,
            :kintai_date_from_disp          
        )
    end

    private
    def get_kintai_date
        (params[:kintai]["kintai_date_from_disp"][0..3] + 
         params[:kintai]["kintai_date_from_disp"][5..6] + 
         params[:kintai]["kintai_date_from_disp"][8..9] +
         params[:kintai]["kintai_from(4i)"] + 
         params[:kintai]["kintai_from(5i)"]).to_datetime - 0.375
    end
end
