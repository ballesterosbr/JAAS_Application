import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import org.bouncycastle.jcajce.provider.digest.SHA3;
import org.bouncycastle.util.encoders.Hex;

public class PlainPasswdModule {

    private String passwdFile;
    private static String REGEX_COLON = "\\s*:\\s*";
    private static String REGEX_COMMA = "\\s*,\\s*";

    private HashMap<String, User> userMap;
    
    public PlainPasswdModule(String file) {
        passwdFile = file;
        userMap = new HashMap<String, User>();
        loadFile();
    }

    protected void loadFile() {
        BufferedReader br = null;

		try {
			String line;
			br = new BufferedReader(new FileReader(passwdFile));
			while ((line = br.readLine()) != null) {
                
                ArrayList<String> items = new ArrayList<String>(Arrays.asList(line.split(REGEX_COLON)));

                if(items.size() < 4) {
                    System.out.println("User incomplete: " + items);
                    continue;
                }

                ArrayList<String> userRoles = new ArrayList<String>(Arrays.asList(items.get(3).split(REGEX_COMMA)));
                
                User user = new User(items.get(0), items.get(1), items.get(2), userRoles);
                user.loadFullName(items.get(0));
                userMap.put(items.get(0), user);
            }
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) br.close();
			} catch (IOException fileException) {
				fileException.printStackTrace();
			}
		}
    }

    public User getUserByLoginName(String loginName) {
        return userMap.get(loginName);
    }

    class User {
        private String loginName;
        private String passHash;
        private String salt;
        private ArrayList<String> roles;
        private String fullName;
        private String pathFile = (System.getProperty("catalina.base") + "/conf/users");

        public User(String _loginName, String _passHash, String _salt, ArrayList<String> _roles) {
            loginName = _loginName;
            passHash = _passHash;
            salt = _salt;
            roles = _roles;
        }

        protected void loadFullName(String _login) {
            BufferedReader br = null;
    
            try {
                String line;
                br = new BufferedReader(new FileReader(pathFile));
                while ((line = br.readLine()) != null) {
                    
                    ArrayList<String> userData = new ArrayList<String>(Arrays.asList(line.split(REGEX_COLON)));

                    if(userData.size() < 3) { continue; }

                    if (_login.equals(userData.get(0))) { fullName = userData.get(1); }
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (br != null) br.close();
                } catch (IOException fileException) {
                    fileException.printStackTrace();
                }
            }
        }

        public String toString() {
            return "Login: " + loginName + "; PassHash: " + passHash + "; Salt: " + salt + "; Roles: " + roles + "; Complete name: "+fullName;
        }

        public String getLoginName() {
            return loginName;
        }

        public String getPassHash() {
            return passHash;
        }

        public String getSalt() {
            return salt;
        }

        public ArrayList<String> getUserRoles() {
            return roles;
        }
        
        public String getFullName() {
            return fullName;
        }

        protected boolean checkPassword (String password) {

            for (int i = 0; i <= 1000; i++) {

                SHA3.DigestSHA3 digestSHA3 = new SHA3.Digest256();
                byte[] pepperDigest = digestSHA3.digest(String.valueOf(i).getBytes());
                String pepperString = Hex.toHexString(pepperDigest);
                String pepper = pepperString.substring(0, Math.min(pepperString.length(), 16));
                String hash = (password+pepper+getSalt());
                byte[] digest = digestSHA3.digest(hash.getBytes());
                if((Hex.toHexString(digest)).equals(getPassHash())) {
                    return true;
                }
            }
            return false;
        }
    }
}