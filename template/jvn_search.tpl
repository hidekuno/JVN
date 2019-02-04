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
          <h1 class="page-header">JVN ベンダー製品情報検索</h1>
          <div class="form-search">
            <form role="form" method="post" action="{{app.topuri}}/jvn_search/search">
            <input type="text" id="vendor_txt" name="vendor"  value="{{app.ui.vendor}}"  class="form-control"  placeholder="ベンダー名称...">
            <input type="text" id="product_txt" name="product" value="{{app.ui.product}}" class="form-control" placeholder="製品名称...">

            <label type="radio-inline">
              <input type="radio" name="fs_manage" id="fs_manage" value="cover_item" {{ app.cover_item }}>
              対象製品　　　　
            </label>
            <label type="radio-inline">
              <input type="radio" name="fs_manage" id="fs_manage" value="not_cover_item" {{ app.not_cover_item }}>
              対象外製品　　　
            </label>
            <label type="radio-inline">
              <input type="radio" name="fs_manage" id="fs_manage" value="undefine" {{ app.undefine }}>
              未定義製品　　　
            </label>

              <button class="btn btn-lg btn-primary jvn-search" id="product_search_btn" type="submit">
              <span class="glyphicon glyphicon-search"></span>検索</button>
            </form>
          </div>

          <div class="table-responsive">
            <table id="product_list_tbl" class="table table-striped">
              <thead>
                <tr>
                  <th>No</th>
                  <th>ベンダー名</th>
                  <th>製品名</th>
                  <th>cpe(/{種別}:{ベンダ名}:{製品名}:{バージョン}:{アップデート}:{エディション}:{言語})</th>
                </tr>
              </thead>
              <tbody>
                {% for item in app.result %}
                <tr>
                  <td>{{ item[0] }}</td>
                  <td>{{ item[1] }}</td>
                  <td>{{ item[2] }}</td>
                  <td>{{ item[3] }}</td>
                </tr>
                {% endfor %}

              </tbody>
            </table>
{% include 'template/jvn_pager.tpl' %}

            <form role="form" method="post" action="{{app.topuri}}/jvn_search/maintenance">
               <button class="btn btn-lg btn-primary jvn-search" id="maintenance_btn" type="submit">
               <span class="glyphicon glyphicon-wrench"></span>メンテナンス</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    {% if app.error_message != '' %}
        <center><h4 style="color:red">{{ app.error_message }}</h4></center>
    {% endif %}
{% include 'template/jvn_footer.tpl' %}
