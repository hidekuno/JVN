{#
 # JVN Vulnerability Infomation Managed System
 #
 # hidekuno@gmail.com
 #
 #}

{% include 'template/jvn_header.tpl' %}
    <div class="container-fluid">
      <div class="row">
        <div class="main">
          <h1 class="page-header">JVN ベンダー製品情報 メンテナンス</h1>
          <button id="cover_item_btn" class="btn btn-sm"><span class="glyphicon glyphicon-ok"></span></button>
          <button id="not_cover_item_btn" class="btn btn-sm"><span class="glyphicon glyphicon-trash"></span></button>
          <div class="table-responsive">
            {% if app.backlink %}
            <form name="execute_back" role="form" class="form-back" method="post" action="{{app.topuri}}/{{app.backlink}}/back">
              <button class="btn btn-lg btn-primary jvn-search" type="submit">
               <span class="glyphicon glyphicon-arrow-left"></span>戻る</button>
            </form>
            {% endif %}
            <form role="form" method="post" action="{{app.topuri}}/jvn_develop/update">
            <table id="product_list_tbl" class="table table-striped">
              <thead>
                <tr>
                  <th>ＦＳ取扱</th>
                  <th>ベンダー名</th>
                  <th>製品名</th>
                  <th>cpe(/{種別}:{ベンダ名}:{製品名}:{バージョン}:{アップデート}:{エディション}:{言語})</th>
                </tr>
              </thead>
              <tbody>
                {% for item in app.result %}
                <tr>
		  <td>
		    <select class="product_select" name="fs_manage{{item[0]}}">
		      {% if item[4] == "cover_item" %}
		      <option value="cover_item" selected>対象</option>
                      {% else %}
		      <option value="cover_item">対象</option>
                      {% endif %}

		      {% if item[4] == "not_cover_item" %}
		      <option value="not_cover_item" selected>対象外</option>
                      {% else %}
		      <option value="not_cover_item">対象外</option>
                      {% endif %}

		      {% if item[4] == "undefine" %}
		      <option value="undefine" selected>未定義</option>
                      {% else %}
		      <option value="undefine">未定義</option>
                      {% endif %}
		    </select>
		  </td>
                  <td>{{ item[1] }}</td>
                  <td>{{ item[2] }}</td>
                  <td>{{ item[3] }}</td>
                </tr>
                {% endfor %}
              </tbody>
            </table>
          </div>
            {% for item in app.result %}
              <input type="hidden" name="vendor{{item[0]}}"  value="{{item[1]}}" />
              <input type="hidden" name="product{{item[0]}}" value="{{item[2]}}" />
              <input type="hidden" name="cpe{{item[0]}}"     value="{{item[3]}}" />
            {% endfor %}
            <button id="execute_btn" class="btn btn-lg btn-primary jvn-search" type="submit">
               <span class="glyphicon glyphicon-pencil"></span>実行</button>
         </form>
        </div>
      </div>
    </div>
    <br>
    <br>
    {% if app.error_message != '' %}
        <center><h4 style="color:red">{{ app.error_message }}</h4></center>
    {% endif %}
{% include 'template/jvn_footer.tpl' %}
