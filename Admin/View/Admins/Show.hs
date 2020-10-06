module Admin.View.Admins.Show where
import Admin.View.Prelude

data ShowView = ShowView { admin :: Admin }

instance View ShowView ViewContext where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={AdminsAction}>Admins</a></li>
                <li class="breadcrumb-item active">Show Admin</li>
            </ol>
        </nav>
        <h1>Show Admin</h1>
    |]
