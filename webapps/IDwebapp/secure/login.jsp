<%--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<html>

<head>
  <title>Login Page</title>

<body>
  <h2>Login required</h2>
  <form method="POST" action='<%= response.encodeURL("j_security_check") %>'>
    <table>
      <tr>
        <th>Username:</th>
        <td><input type="text" name="j_username"></td>
      </tr>
      <tr>
        <th>Password:</th>
        <td><input type="password" name="j_password"></td>
      </tr>
      <tr>
        <td><input type="submit" value="Log In"></td>
      </tr>
    </table>
  </form>
</body>

</html>