The User Home extension allows you to edit the landing page for your users. When they login and
a `home_path` is set on their account, they will be redirected to that URL.

Each user may also set their own home location in their preferences.

A warning message may appear if the user_home extension is present, but the database has not
been migrated to include the `home_path` field.