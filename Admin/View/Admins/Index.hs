module Admin.View.Admins.Index where
import Admin.View.Prelude

data IndexView = IndexView { admins :: [Admin] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={AdminsAction}>Admins</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewAdminAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Admin</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach admins renderAdmin}</tbody>
            </table>
        </div>
    |]


renderAdmin admin = [hsx|
    <tr>
        <td>{admin}</td>
        <td><a href={ShowAdminAction admin.id}>Show</a></td>
        <td><a href={EditAdminAction admin.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteAdminAction admin.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
