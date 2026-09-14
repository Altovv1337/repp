package guide.anticheat;

import java.util.*;

/**
 * Учебный пример сигнатурного сканера.
 * Сравнивает контрольные суммы загруженных модулей
 * со списком доверенных значений.
 *
 */
public class SignatureScanner {

    private final Set<String> trustedHashes;

    public SignatureScanner(Set<String> trustedHashes) {
        this.trustedHashes = new HashSet<>(trustedHashes);
    }

    public boolean isTrusted(String moduleHash) {
        return trustedHashes.contains(moduleHash);
    }

    public List<String> findUntrusted(List<String> loadedModuleHashes) {
        List<String> suspicious = new ArrayList<>();
        for (String hash : loadedModuleHashes) {
            if (!isTrusted(hash)) {
                suspicious.add(hash);
            }
        }
        return suspicious;
    }
}
